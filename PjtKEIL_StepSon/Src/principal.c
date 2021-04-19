

#include "DriverJeuLaser.h"
extern short Son; 
extern int Longeurson; 
extern int PeriodeSonMicroSec;

void CallbackSon(void);

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();

//configuration du Timer 4 en débordement 

Timer_1234_Init_ff(TIM4, 72*91); 

Active_IT_Debordement_Timer( TIM4, 2, CallbackSon); 
	
GPIO_Configure(GPIOB, 1, OUTPUT, OUTPUT_PPULL); 	
	
	

//============================================================================	
	
	
while	(1)
	{
	}
}

