There are two functions and one experiment program in this experiment.
	1.generate_dataset.m is a dataset generation function.
	2.classify_perceptron.m is the perceptron learning toword linear learning function.
	3.experiment.m is the experiment code, which will cost a long time to run.
		( because it will go through 10 different learning rates from 0.1 to 1.
			Each learning rate include 10 different separations from 0.5 to 5 )

Quikly test:
	To quickly test the algorithm, run the following code in the command box in matlab,
	
	classify_perceptron(0.5, 0.5)
	
	the first parameter is separation, the second one is learning rate.
	Both the parameters can be modified to make different experiments.