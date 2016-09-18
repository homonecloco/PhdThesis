# Run Kallisto on a single sample #
expVIP can run ```Kallisto``` and load the ```tpm``` and ```counts``` to the database. The only requirement is to run ```kallisto index ``` on the transcriptome reference. 

## Graphical interface
1. Double click on ```run_kallisto.sh```
![alt text](images/RunKallisto01.png "")
1. Click on ```Execute on terminal```
![alt text](images/RunKallisto02.png "")
1. Give a name to the set of mappings to be grouped. All mappings done with the same reference and preference should have the same name. 
![alt text](images/RunKallisto03.png "")
1. Get the name of the reference. This name must be the same used when loading the [metadata](LoadingMetadata) 
![alt text](images/RunKallisto04.png "")
1. Select a folder with the reads. The reads must be paired reads. The folder name must be the same as the ```accession``` used on the metadata. 
![alt text](images/RunKallisto05.png "")
1. Select the kallisto index
![alt text](images/RunKallisto07.png "")
1. Wait for Kallisto to run and load the data
![alt text](images/RunKallisto08.png "")

You can reepeat this with all the samples or you can use the [batch load](RunKallistoBatch). 

## Rake task ##


```sh
kallisto:runAndStorePaired[kallistoIndex,input_folder,metaExperimentName,geneSetName]
```

Where ```metaExperimentName``` is the name of the group of alignments under the same conditions and ```geneSetName`` is the name of the reference. 
