require 'rubygems'
#require 'extensions/all'
require 'bio-samtools'

require_relative 'BFRTools.rb'

#puts "hello!"

project_folder="/data/workarea/ramirezr/SEQINFO-386"

aligments_folder = project_folder + ""

reference="Ta.seq.uniq"


succeptible = ARGV[0]
resistant = ARGV[1]
chunk = ARGV[2].to_i
chunk_size = ARGV[3].to_i
output_filename = ARGV[4]
stats_file = ARGV[5]
#reference = ARGV[6]

testReference = project_folder + "/references/Unigenes_v60/" + reference

min = chunk * chunk_size
max = min + chunk_size

#AvocetS
parental_1=project_folder + "/01_align/original_reads/Ta.seq.uniq/Sample_LIB1721/Sample_LIB1721.uniq.rmdup.bam"
#AvocetS (Yr15)
parental_2=project_folder + "/01_align/original_reads/Ta.seq.uniq/Sample_LIB1722/Sample_LIB1722.uniq.rmdup.bam"


bulk_1 = project_folder + "/01_align/original_reads/Ta.seq.uniq/Sample_"+ resistant +"/Sample_"+ resistant +".uniq.rmdup.bam"
bulk_2 = project_folder + "/01_align/original_reads/Ta.seq.uniq/Sample_"+ succeptible +"/Sample_"+ succeptible +".uniq.rmdup.bam"

fasta_db = Bio::DB::Fasta::FastaFile.new(testReference)
fasta_db.load_fai_entries


container = Bio::BFRTools::BFRContainer.new

container.reference testReference
container.parental_1  ( {:path => parental_1, :name => "AvocetS" } )
container.parental_2  ( {:path => parental_2, :name => "AvocetS(Yr15)" } )
container.bulk_1 ( {:path => bulk_1 , :name => resistant })
container.bulk_2 ( {:path => bulk_2 ,  :name => succeptible})

i = 0

container.init_counters
output_file =  File.open(output_filename, "w")
fasta_db.index.entries.each do | r |
  i = i  + 1
  next if i < min or i >= max 
  container.process_region({:region => r.get_full_region.to_s,:output_file => output_file } )
end
output_file.close

file_h = nil
if !File.exists? stats_file
  file_h = File.open(stats_file, "w")
  container.print_header({:output_file_stats => file_h})
else
  file_h =  File.open(stats_file, "a")
end
container.print_stats({:output_file_stats => file_h})

file_h.close

