#include "DriverJeuLaser.h"
#include "GestionSon.h"
	
extern int DFT_ModuleAuCarre(short int*, char);

extern short int LeSignal;

short int dma_buf[64] ;

int resultat[64];
int compteur[6];
int score[6] = {0,0,0,0,0,0};

void sys_callback(void) {
	
	
	
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
	
	
	int SEUIL=0x56a8c;
	char k;

	for(k=0;k<64;k++){
		resultat[k] = DFT_ModuleAuCarre(dma_buf, k);
                if (resultat[k]>SEUIL){
//on verifie pour les 6 valeurs de cas possibles si on prend en compte 
//le tir ou pas  et ce pour les differentes valeurs de frequences pour chaque joueur
                      switch(k){
					case 17:
						compteur[0]++; 
						score[0]++;
						StartSon();
						break;
					case 18:
						compteur[1]++; 
						score[1]++;
						StartSon();
						break;
					case 19:
						compteur[2]++;
						score[2]++;
						StartSon();
						break ;
					case 20:
						compteur[3]++;
						score[3]++;
						StartSon();
						break;
					case 23:
						compteur[4]++;
						score[4]++;
						StartSon();
						break;
					case 24:
						compteur[5]++; 
						score[5]++;
						StartSon();
						break;
                           }		
                        }
//sinon on remet à 0 
                             	else {
					switch(k){ 
					case 17:
						compteur[0]=0; 
						break;
					case 18:
						compteur[1]=0; 
						break;
					case 19:
						compteur[2]=0; 
						break ;
					case 20:
						compteur[3]=0; 
						break;
					case 23:
						compteur[4]=0; 
						break;
					case 24:
						compteur[5]=0; 
						break;
				}
			}
		}		

}
int main() {
// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();


Systick_Period_ff(360000);
Systick_Prio_IT(1, sys_callback);
SysTick_On ;
SysTick_Enable_IT ;
	


Init_TimingADC_ActiveADC_ff( ADC1, 72 );
Single_Channel_ADC( ADC1, 2 );
Init_Conversion_On_Trig_Timer_ff( ADC1, TIM2_CC2, 225 );
Init_ADC1_DMA1(0,dma_buf);
	
	
	

Timer_1234_Init_ff(TIM4, 6552); 
Active_IT_Debordement_Timer( TIM4, 2, CallbackSon);


PWM_Init_ff(TIM3, 3, 720);
GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);	




while	(1)
	{	
	}
}		