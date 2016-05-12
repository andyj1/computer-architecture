#include <stdio.h>
#include <string.h>
typedef struct Labels{
	char strVal[20]; 	//name of label
	char actualVal[20];		//actual value
	char type[20];		//type of data, almost always will be bytes
	char location[8];	//absolute address
} Label;

typedef struct instrLabels{
	char inst_loc[20];
	int location;
} instrLabel;

const char *bit_rep[16] = {
    [ 0] = "0000", [ 1] = "0001", [ 2] = "0010", [ 3] = "0011",
    [ 4] = "0100", [ 5] = "0101", [ 6] = "0110", [ 7] = "0111",
    [ 8] = "1000", [ 9] = "1001", [10] = "1010", [11] = "1011",
    [12] = "1100", [13] = "1101", [14] = "1110", [15] = "1111",
};
int main(){
	//initialization
	FILE *fptr;	//
	FILE *intfptr;	//intermediate file
	FILE *outfptr;	//output file
	char buf[255];
	char newNameBuf[]="link";
	char interbuf[1024];
	char *buffer[1024];
	char *outbuf[1024];
	int text = 0;
	int data = 77;
	//open input and output file
	printf("Enter input: ");	
	scanf("%s", buf);
	//printf("Enter an linker file name: ");
	//scanf("%s", newNameBuf);
	//printf("Starting to preassemble...\n");
	fptr = fopen(buf, "r+");
	intfptr = fopen("intermediate.txt","w+");
	outfptr = fopen(newNameBuf, "w");
	
	//error catching
	if (!fptr){
		return 1;
	}
	//store labels in a library
	Label labellist[8];
	instrLabel instrLabellist[4];
	int i = 0;
	int numLabel = 0;
	
	//first change all the pseudo code to core ISA code
	//takes in input file (fptr) and gives new textfile 
	//interbuf is the input buffer

	fgets(buf, 1000, fptr);
	while (fgets(buf,1000, fptr)!=NULL && buf[1] != 't'){
		
		char numberbuf[3] = {0};
		int j = 1; //goes through the buffer
		int k = 0;
		while (buf[j] != ' '){
			//stores the type
			(labellist[i]).type[k] = buf[j];
			k++;
			j++;
		}
		j += 1;
		k = 0;
		
		while (buf[j] != ' '){
			//stores the label
			(labellist[i]).strVal[k] = buf[j];
			k++;
			j++;
		}
		j += 1;
		k = 0;
		
		while (buf[j] <= 57 && buf[j] >= 48 && k < 3){
			//stores the actual value
			numberbuf[k] = buf[j];
			k++;
			j++;
		}
		
		int val = 0;
		int m = 0;
		while(numberbuf[m] != 0){
			val *=10;
			val += numberbuf[m] - '0';
			m ++;
		}		
		int dec_val_beg = val/16;
		int dec_val_end = val%16;
		int dec_loc_beg = (data+i)/16;
		int dec_loc_end = (data+i)%16;
		sprintf(labellist[i].location,"%s%s",bit_rep[dec_loc_beg],bit_rep[dec_loc_end]);

		sprintf(labellist[i].actualVal,"%s%s",bit_rep[dec_val_beg],bit_rep[dec_val_end]);
		fprintf(intfptr,"%s\n", labellist[i].actualVal);
		
		i++;
	}
	fprintf(intfptr, "%s\n", buf);
	while (fgets(buf,1000,fptr) != NULL){
		if (buf[0] == 'l' && buf[1] == 'a'){
			//load address psuedo code
			//e.g. la $r1, var1
			int j = 0;
			int k = 0;
			int stillOK = 1;
			char buffy[20];
			char rt[4] = {0,0,0,0};
			char myByte[8];	//stores the Byte
			while (buf[j] != ' '){
				j++;
			}
			j += 1;
			
			while (buf[j] != ' '&& k < 3){
				rt[k] = buf[j];
				k++;
				j++;
			}
			j += 1;
			k = 0;
			
			while (buf[j] != '\0'||k<3){
				//stores the actual value
				buffy[k] = buf[j];
				k++;
				j++;
			}
			
			
			for (int m = 0; m < 8; m++){
				stillOK = 1;
				for (int n = 0; n < strlen(labellist[m].strVal); n++){
					if ((labellist[m].strVal)[n] != buffy[n]){
						stillOK = 0;
					}
					if (stillOK == 0){
						break;
					}
				}
				if (stillOK == 1){
					for (int g = 0; g < 8; g++){
						myByte[g] = (labellist[m].location)[g];
					}
					//fprintf(intfptr,"sl %s %s\n", rt,rt);
					for (int m = 0; m < 8; m++){
						fprintf(intfptr,"sl %s %s\n", rt,rt);
						if (myByte[m] == '1'){
							fprintf(intfptr,"addi 1 %s\n", rt);
						}
					}
					break;
				}
			}
		}else{
			fprintf(intfptr, "%s", buf);
		}
	}
	rewind(intfptr);
	//first scan through the whole file and convert labels to numbers
	//store labels as structs
	int count = 0;
	while (fgets(buf,1000, intfptr)!=NULL){
		int a = 0;
		int d = 0;
		while (buf[a] != ':' && buf[a] != '\0'){
			a++;
		}
		if (buf[a] == ':'){
			for (int b = 0; b < a; b++){
				instrLabellist[numLabel].inst_loc[b] = buf[b];
			}
			instrLabellist[numLabel].location = count;
			numLabel += 1;
		}
		count += 1;
	}
	
	rewind(intfptr);
	int checkers;
	int cur_loc = 1;
	while (fgets(buf,1000, intfptr)!=NULL && checkers <= i){
		fprintf(outfptr,"%s",buf);
		checkers++;
		cur_loc += 1;
	}
	
	//Go through intermediate file and change all labels to numbers for jal and beq
	while (fgets(buf,1000, intfptr)!=NULL){
		if ((buf[0] == 'j' && buf[1] == 'a' & buf[2] == 'l') || (buf[0] == 'b' && buf[1] == 'e' & buf[2] == 'q')){
			
			int j = 0;
			int k = 0;
			int stillOK = 1;
			char instLabel[10];
			
			while (buf[j] != ' '){
				j++;
			}
			j += 1;
			
			while ((buf[j] >= 48 && buf[j] <= 57)||(buf[j] >= 65 && buf[j] <= 90)||(buf[j] >= 97 && buf[j] <= 122)){
				instLabel[k] = buf[j];
				k++;
				j++;
			}
			
			for (int m = 0; m < numLabel; m++){
				stillOK = 1;
				for (int n = 0; n < strlen(instrLabellist[m].inst_loc); n++){
					if ((instrLabellist[m].inst_loc)[n] != instLabel[n]){
						stillOK = 0;
						break;
					}
				}
				if (stillOK == 1){
					int offset;
					offset = instrLabellist[m].location - cur_loc ;
					if (buf[0] == 'b'){
						fprintf(outfptr, "beq %d\n", offset);
					}else{
						fprintf(outfptr, "jal %d\n", offset);
					}
					break;
				}
			}
			
			
		}else{
			int a = 0;
			int d = 0;
			char bufff[1024] = {'\0'};
			char newbuf[1024] = {'\0'};
			while (buf[a] != ':' && buf[a] != '\0' && buf[a] != 10){
				bufff[a] = buf[a];
				a++;
			}
			if (buf[a] == ':'){
				a += 2;
				while (buf[a] != '\0'){
					newbuf[d] = buf[a];
					a++;
					d++;
				}
				if ((newbuf[0] == 'j' && newbuf[1] == 'a' & newbuf[2] == 'l') || (newbuf[0] == 'b' && newbuf[1] == 'e' & newbuf[2] == 'q')){
			
				int j = 0;
				int k = 0;
				int stillOK = 1;
				char instLabel[10];
			
					while (newbuf[j] != ' '){
						j++;
					}
					j += 1;
			
					while ((newbuf[j] >= 48 && newbuf[j] <= 57)||(newbuf[j] >= 65 && newbuf[j] <= 90)||(newbuf[j] >= 97 && newbuf[j] <= 122)){
						instLabel[k] = newbuf[j];
						k++;
						j++;
					}
			
					for (int m = 0; m < numLabel; m++){
						stillOK = 1;
						for (int n = 0; n < strlen(instrLabellist[m].inst_loc); n++){
							if ((instrLabellist[m].inst_loc)[n] != instLabel[n]){
								stillOK = 0;
								break;
							}
						}
						if (stillOK == 1){
							int offset;
							offset = instrLabellist[m].location - cur_loc ;
							if (buf[0] == 'b'){
								fprintf(outfptr, "beq %d\n", offset);
							}else{
								fprintf(outfptr, "jal %d\n", offset);
							}
							break;
						}
					}

				}else{
					fprintf(outfptr,"%s",newbuf);
				}
				//fprintf(outfptr,"%s",newbuf);				
			}else{
				fprintf(outfptr,"%s\n",bufff);
			}
		}
		cur_loc += 1;
	}		
	
	fclose(fptr);
	fclose(outfptr);
	fclose(intfptr);
	printf("Preassembly complete\n");
	//spit out an output file
	return 0;
}
