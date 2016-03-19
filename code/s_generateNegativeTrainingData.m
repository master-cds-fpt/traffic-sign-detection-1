% bluePositiveSamples = f_generateColorTrainingData('../files/',3,100);   
 redPositiveSamples = f_generateColorTrainingData('../files/',1,100);
% blueNegativeSamples = f_generateNegativeTrainingData('../files/',3,100);
redNegativeSamples = f_generateNegativeTrainingData('../files/',1,100);
blueNegativeSamples = squeeze(blueNegativeSamples);
redNegativeSamples = squeeze(redNegativeSamples);
bluePositiveSamples = squeeze(bluePositiveSamples);
redPositiveSamples = squeeze(redPositiveSamples);


save('../data/negativeSamples', 'blueNegativeSamples', 'redNegativeSamples');
save('../data/positiveSamples', 'bluePositiveSamples', 'redPositiveSamples');
