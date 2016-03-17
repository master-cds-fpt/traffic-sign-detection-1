numSamples = 200000;
blueNegativeSamples = f_generateNegativeTrainingData('../files/',3,100);
redNegativeSamples = f_generateNegativeTrainingData('../files/',1,100);
save('../data/negativeSamples', 'blueNegativeSamples', 'redNegativeSamples');