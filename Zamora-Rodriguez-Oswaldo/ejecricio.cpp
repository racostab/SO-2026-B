#include <iostream>
#include <unistd.h>

using namespace std;

int main(){

    int proceso;

    proceso = fork();

    if(proceso == 0){
        cout << "soy hijo" << endl;
        cout << "mi pid es " << getpid() << endl;
    }
    else{
        cout << "Luke soy tu padre" << endl;
        cout << "mi pid es " << getpid() << endl;
    }

    return 0;
}
