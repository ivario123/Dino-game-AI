import java.util.Random;
import java.lang.Math;
import processing.core.PApplet;
import java.io.Serializable;
class Matrix implements Serializable {
  public float[][] table;
  public int m;
  public int n;
  public Matrix(int m, int n) {
  this.m = m;
  this.n = n;
  table = new float[m][n];
  for(int i = 0; i < m; i++){
    for(int j = 0; j < n; j++){
     table[i][j]=0; 
    }
  }
  }
  static public Matrix rAdd(Matrix m){
    Random r = new Random();
    for(int i = 0; i < m.n; i++){
     for(int j = 0; j < m.m; j++){
      m.table[j][i]+=(r.nextFloat()-0.5f)*0.1f; 
     }
    }
    return m;
  }
  static public Matrix mMult(Matrix A, Matrix B) {
    Matrix o  = new Matrix(A.m,B.n);
    for(int i = 0; i < A.m; i++){
       for(int j = 0; j < B.n; j++){
        for(int k  = 0; k < B.m; k++){
         o.table[i][j]+=A.table[i][k]*B.table[k][j]; 
        }
       }
    }
    return o;
  }
  static public Matrix tanh(Matrix A){
   for(int i = 0; i < A.m; i++){
    for(int j = 0; j < A.n; j++){
      A.table[i][j] = (float)(Math.exp((float)A.table[i][j])/(1+Math.exp((float)A.table[i][j])));
    }
   }
   return A;
  }
  public void randomize(){
    Random r = new Random();
    for(int i = 0; i < m; i++){
     for(int j = 0; j < n ; j++){
      table[i][j]=r.nextFloat()/2; 
     }
    }
  }
  static public Matrix nMult(float val, Matrix A){
   for(int i = 0; i < A.m; i++){
    for(int j = 0; j <A.n; j++){
     A.table[i][j]*=val; 
    }
   }
   return A;
  }
  static public Matrix mAdd(Matrix A,Matrix B){
    Matrix o  = new Matrix(A.m,B.n);
    for(int i = 0; i < A.m; i++){
       for(int j = 0; j < A.n; j++){
        o.table[i][j]=A.table[i][j]+B.table[i][j];
       }
    }
    return o;
    
  }
  static public Matrix mSub(Matrix A, Matrix B){
    return mAdd(A,nMult(-1f,B));
  }
  static public Matrix nCross(Matrix A, Matrix B, int WeightA, int WeightB){
    Matrix temp = new Matrix(A.m,A.n);
    float Amult = ((float)WeightA)/((float)WeightA+(float)WeightB);
    float Bmult = ((float)WeightB)/((float)WeightA+(float)WeightB);
    for(int i = 0; i < A.m; i++){
     for(int j = 0; j < A.n; j++){
      temp.table[i][j] = A.table[i][j]*Amult+B.table[i][j]*Bmult; 
     }
    }
    return temp;
  }
}
