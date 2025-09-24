import 'dart:math';

BigInt factorial(BigInt n){
  if(n<=BigInt.zero){
   return BigInt.zero;
  }else{
    if ( n==BigInt.one ) {
      return BigInt.one;
    }else {
     return n * factorial(n - BigInt.one);
    }
  }
}



void main(){
  print(factorial(BigInt.from(3)));
}