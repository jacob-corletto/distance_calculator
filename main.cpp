#include <stdio.h>
#include <cstring>
#include <iostream>
using namespace std;

extern "C" void hello_world();
extern "C" void compute_trip();

int main(){

  //hello_world();
  compute_trip();
  

  cout << "The main module received this number and will keep it for a while." << endl;
  cout << "A zero will be sent to your operating system." << endl;
  cout << "Good-bye. Have a great trip." <<endl;
  return 0;

}//End of main