//
//  Main.cpp
//  002_Square
//
//  Created by Daiyi on 2021/4/20.
//

#include <stdio.h>
#include "GLShaderManager.h"
#include "GLTools.h"
#include <GLUT/GLUT.h>

//定义一个，着色管理器
GLShaderManager shaderManager;

//简单的批次容器，是GLTools的一个简单的容器类。
GLBatch triangleBatch;


//blockSize 边长
GLfloat blockSize = 0.1f;

// 左边边界
GLfloat leftSide = -1.0f + blockSize;
// 右边边界
GLfloat rightSide = 1.0 - blockSize;

// 上边边界
GLfloat topSide = leftSide;
// 下边边界
GLfloat bottomSide = rightSide;

//正方形的4个点坐标
GLfloat vVerts[] = {
        -blockSize,-blockSize,0.0f,
        blockSize,-blockSize,0.0f,
        blockSize,blockSize,0.0f,
        -blockSize,blockSize,0.0f
};

GLfloat xPos = 0;
GLfloat yPos = 0;



/*
 在窗口大小改变时，接收新的宽度&高度。
 */
void changeSize(int w,int h)
{
    /*
      x,y 参数代表窗口中视图的左下角坐标，而宽度、高度是像素为表示，通常x,y 都是为0
     */
    glViewport(0, 0, w, h);
    
}

void RenderScene(void) {
    /*
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT|GL_STENCIL_BUFFER_BIT);
    GLfloat vRed[] = {1.0,0.0,0.0,1.0f};
    shaderManager.UseStockShader(GLT_SHADER_IDENTITY, vRed);
    
    triangleBatch.Draw();
    glutSwapBuffers();
     */
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT|GL_STENCIL_BUFFER_BIT);
    GLfloat vRed[] = {1.0,0.0,0.0,1.0f};
//    shaderManager.UseStockShader(GLT_SHADER_IDENTITY, vRed);
    
    M3DMatrix44f mTransformMatrix, mRotationMatrix, mFinalTransform;
    m3dTranslationMatrix44(mTransformMatrix, xPos, yPos, 0.0f);
    static float ZRot = 0.0f;
    ZRot += 5.0f;
    m3dRotationMatrix44(mRotationMatrix, m3dDegToRad(ZRot), 0.0f, 0.0f, 1.0f);
    
    m3dMatrixMultiply44(mFinalTransform, mTransformMatrix, mRotationMatrix);
    
    // 矩阵相乘
    shaderManager.UseStockShader(GLT_SHADER_FLAT, mFinalTransform , vRed);
    
    
    triangleBatch.Draw();
    glutSwapBuffers();
    
    
}

void setupRC() {
    glClearColor(0.98f, 0.40f, 0.7f, 1);
    shaderManager.InitializeStockShaders();
    //修改为GL_TRIANGLE_FAN ，4个顶点
    triangleBatch.Begin(GL_TRIANGLE_FAN, 4);
    triangleBatch.CopyVertexData3f(vVerts);
    triangleBatch.End();
}

void SpecialKeys(int key, int x, int y){
    GLfloat stepSize = 0.025f;
    
    if (key == GLUT_KEY_UP) {
        yPos += stepSize;
    }
    
    if (key == GLUT_KEY_DOWN) {
        yPos -= stepSize;
    }
    
    if (key == GLUT_KEY_LEFT) {
        xPos -= stepSize;
    }
    
    if (key == GLUT_KEY_RIGHT) {
        xPos += stepSize;
    }
    
    // 便捷检测
    if (xPos < leftSide) {
        xPos = leftSide;
    }
    if (xPos > rightSide) {
        xPos = rightSide;
    }
    
    if (yPos < topSide) {
        yPos = topSide;
    }
    if (yPos > bottomSide) {
        yPos = bottomSide;
    }
    glutPostRedisplay();
    /*
    GLfloat blockX = vVerts[0];
    GLfloat blockY = vVerts[10];
    
    printf("v[0] = %f\n",blockX);
    printf("v[10] = %f\n",blockY);
    
    
    if (key == GLUT_KEY_UP) {
        blockY += stepSize;
    }
    
    if (key == GLUT_KEY_DOWN) {
        blockY -= stepSize;
    }
    
    if (key == GLUT_KEY_LEFT) {
        blockX -= stepSize;
    }
    
    if (key == GLUT_KEY_RIGHT) {
        blockX += stepSize;
    }

    //触碰到边界（4个边界）的处理
    
    //当正方形移动超过最左边的时候
    if (blockX < -1.0f) {
        blockX = -1.0f;
    }
    
    //当正方形移动到最右边时
    //1.0 - blockSize * 2 = 总边长 - 正方形的边长 = 最左边点的位置
    if (blockX > (1.0 - blockSize * 2)) {
        blockX = 1.0f - blockSize * 2;
    }
    
    //当正方形移动到最下面时
    //-1.0 - blockSize * 2 = Y（负轴边界） - 正方形边长 = 最下面点的位置
    if (blockY < -1.0f + blockSize * 2 ) {
        
        blockY = -1.0f + blockSize * 2;
    }
    
    //当正方形移动到最上面时
    if (blockY > 1.0f) {
        blockY = 1.0f;
    }
    
    
    
    printf("blockX = %f\n",blockX);
    printf("blockY = %f\n",blockY);
    
    // Recalculate vertex positions
    vVerts[0] = blockX;
    vVerts[1] = blockY - blockSize*2;
    
    printf("(%f,%f)\n",vVerts[0],vVerts[1]);
    
    
    vVerts[3] = blockX + blockSize*2;
    vVerts[4] = blockY - blockSize*2;
    printf("(%f,%f)\n",vVerts[3],vVerts[4]);
    
    vVerts[6] = blockX + blockSize*2;
    vVerts[7] = blockY;
    printf("(%f,%f)\n",vVerts[6],vVerts[7]);
    
    vVerts[9] = blockX;
    vVerts[10] = blockY;
    printf("(%f,%f)\n",vVerts[9],vVerts[10]);
     
    triangleBatch.CopyVertexData3f(vVerts);
    glutPostRedisplay();
     
     */
}


int main(int argc, char *argv[]) {
    gltSetWorkingDirectory(argv[0]);
    glutInit(&argc, argv);
    
    glutInitDisplayMode(GLUT_DOUBLE|GLUT_RGBA|GLUT_DEPTH|GLUT_STENCIL);
    
    glutInitWindowSize(800, 600);
    glutCreateWindow("Square");
    
    glutReshapeFunc(changeSize);
    glutDisplayFunc(RenderScene);
    glutSpecialFunc(SpecialKeys);
    
    GLenum status = glewInit();
    if (GLEW_OK != status) {
        printf("GLEW Error: %s\n", glewGetErrorString(status));
        return -1;
    }
    // 设置我们的渲染环境
    setupRC();
    glutMainLoop();
    
    return 0;
}
