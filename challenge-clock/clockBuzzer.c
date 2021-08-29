/*    Buzzer Challenge     */

#include<reg51.h>
#include<stdio.h>
#include<stdlib.h>

// LCD Control Variables
sbit rs = P1^0;
sbit rw = P1^1;
sbit en = P1^2;

// LCD Functions
void lcdcmd(unsigned char);
void lcddat(unsigned char);
void delay();           // fixed delay

// I/O Variables
sbit comp3 = P0^3;      // MSB output of processed data [OUT]
sbit comp2 = P0^2;
sbit comp1 = P0^1;
sbit comp0 = P0^0;

sbit opsHi = P0^7;      //MSB of operation selector [IN]
sbit opsLo = P0^6;

sbit comparision = P0^4;
sbit buzz  = P3^0;      // Buzzer

sbit temp3 = P3^7;
sbit temp2 = P3^6;
sbit temp1 = P3^5;
sbit temp0 = P3^4;

unsigned char randomNum, rnb;   // rnb = random number backup

// Main
void main() {
    P2 = 0x00;          // init data lines to 0
    comparision = 0;    // init compr test to 0
    // Random number generator
    randomNum = rand() % 10;    // Mod 10 reduces the out: 0-9


    if (opsHi == 0 && opsLo == 1){
        // Assigning bits
        // Adding 3 before binary conversion for excess3 special case
        randomNum = randomNum + 3;
        temp0 = randomNum % 10;         // 1234 -> 4
        randomNum = randomNum / 10;     // 1234 -> 123
        temp1 = randomNum % 10;         // 0123 -> 3
        randomNum = randomNum / 10;     // 0123 -> 0012
        temp2 = randomNum % 10;         // 0012 -> 2
        randomNum = randomNum / 10;     // 0001
        temp3 = randomNum;
    }
    else {
        // Assigning bits
        temp0 = randomNum % 10;         // 1234 -> 4
        randomNum = randomNum / 10;     // 1234 -> 123
        temp1 = randomNum % 10;         // 0123 -> 3
        randomNum = randomNum / 10;     // 0123 -> 0012
        temp2 = randomNum % 10;         // 0012 -> 2
        randomNum = randomNum / 10;     // 0001
        temp3 = randomNum;
    }

    /*     ====  Operations   ===       */
    // Level 0: 1s C
        if (opsHi == 0 && opsLo == 0) {
            comp3 =~ temp3;
            comp2 =~ temp2;
            comp1 =~ temp1;
            comp0 =~ temp0;
        }


    // Level 1: E3
        if (opsHi == 0 && opsLo == 1) {
            comp3 = temp3;
            comp2 = temp2;
            comp1 = temp1;
            comp0 = temp0;
        }

    // Level 2: Binary to gray conversion
        if (opsHi == 1 && opsLo == 0) {
            comp3 = temp3;
            comp2 = temp3 ^ temp2;
            comp1 = temp2 ^ temp1;
            comp0 = temp1 ^ temp0;
        }

    // Level 3: Gray to binary conversion
        if (opsHi == 1 && opsLo == 0) {
            comp3 = temp3;
            comp2 = comp3 ^ temp2;
            comp1 = comp2 ^ temp1;
            comp0 = comp1 ^ temp0;
        }



    // Loop for LCD output and buzzer [quit on compr = 1]
    while(1) {
        // Buzzer
        buzz = 1;
        delay();
        buzz = 0;
        delay();

        // LCD Output
                // LCD init
        lcdcmd(0x38);       // 5x7 crystal matrix
        delay();
        lcdcmd(0x01);       // Clear screen
        delay();
        lcdcmd(0x10);       // Cursor blinking
        delay();
        lcdcmd(0x0C);       // Display ON
        delay();

                // Passing data
        lcddat(rnb);
        delay();

        // Break condition when user enters correct input
        if(comparision == 1) {
            break;
        }
    }


    // LCD Commands
    void lcdcmd(unsigned char val) {
        P2 = val;
        rs = 0;         // operation mode
        rw = 0;         // operation mode
        en = 1;         // pulse generation
        delay();
        en = 0;
    }

    void lcddat(unsigned char val) {
        P2 = val;
        rs = 1;         // write mode
        rw = 0;         // write mode
        en = 1;         // pulse generation
        delay();
        en = 0;
    }
    
    // Delay
    void delay() {
        unsigned int i;
        for(i = 0; i < 12000; i++);
    }
}

