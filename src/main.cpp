#include <iostream>
#include <fstream>


int main(){
  
  // Writing to file
  std::ofstream outfile;
  outfile.open("bin/output/test.txt", std::ios_base::app);
  outfile << "Hello friend";



  std::cout << "Hello friend" << std::endl;

  return 0;
}
