# Run Kallisto on a multiple samples #
expVIP can run ```Kallisto``` and load the ```tpm``` and ```counts``` to the database from multiple samples. The only requirement is to run ```kallisto index ``` on the transcriptome reference. 

## Graphical interface
1. Double click on ```run_kallisto.sh```
![alt text](images/KallistoBatch01.png "")
1. Click on ```Execute on terminal```
![alt text](images/KallistoBatch02.png "")
1. Give a name to the set of mappings to be grouped. All mappings done with the same reference and preference should have the same name. 
![alt text](images/KallistoBatch03.png "")
1. Get the name of the reference. This name must be the same used when loading the [metadata](LoadingMetadata) 
![alt text](images/KallistoBatch04.png "")
1. Select a folder with the folders containing the reads. The reads must be paired reads. The subfolder names must be the same as the ```accession``` used on the metadata.  If a subfolder has an experiment that has been loaded already, it is not loaded.
![alt text](images/KallistoBatch05.png "")
1. Select the kallisto index
![alt text](images/RunKallisto07.png "")
1. Wait for Kallisto to run and load the data
![alt text](images/KallistoBatch07.png "")

Repeat this with all the samples. 

## Rake task ##


```sh
kallisto:runAndStorePairedFolder[kallistoIndex,input_folder,metaExperimentName,geneSetName]
```

Where ```metaExperimentName``` is the name of the group of alignments under the same conditions and ```geneSetName`` is the name of the reference. 
