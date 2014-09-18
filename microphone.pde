// for the microphone
const int noisePin = A1;
const int middleValue = 512;      //the middle of the range of analog values
const int numberOfSamples = 128;  //how many readings will be taken each time

int sample;                       			//the value read from microphone each time
long sig;                      					//the reading once you have removed DC offset
long averageReading;              			//the average of that loop of readings

long runningAverage = 0;          			//the running average of calculated values
const int averagedOver = 16;     				//how quickly new values affect running average
                                				//bigger numbers mean slower
const int threshold = 400;        			//at what level the light turns on

void detectNoise() {
    long sumOfSquares = 0;
    for (int i=0; i<numberOfSamples; i++) {     //take many readings and average them
        sample = analogRead(noisePin);          //take a reading
        sig = (sample - middleValue);           //work out its offset from the center
        sig *= sig;                           	//square it to make all values positive
        sumOfSquares += sig;                    //add to the total
    }
    averageReading = sumOfSquares / numberOfSamples;     //calculate running average
    runningAverage = ( ( (averagedOver - 1) * runningAverage ) + averageReading ) / averagedOver;

    if (runningAverage > threshold) {         	//is average more than the threshold ?
        noisy = true;                           //if it is turn on the LED
    } else {
        noisy = false;                          //if it isn't turn the LED off
    }
    Serial.println(runningAverage);        			//print the value so you can check it
}