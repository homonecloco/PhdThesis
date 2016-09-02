require 'bio'

class Bio::Blat::StreamedReport < Report 
  def self.each_hit(text = '')
    flag = false
    head = []
    text.each_line do |line|
        line = line.chomp
        if /\A\-+\s*\z/ =~ line
          flag = true
        else
          head << line
        end
      end
    end

def self.each_best_hit(text = '')
  emptyHit = Bio::Blat::Report::Hit.new
  emptyHit.score = 0
  best_aln = Hash.new(emptyHit)
  self.each_hit(text) do |hit|
    current_score = hit.score
    if current_score > best_aln[current_name].score
      best_aln[current_name] = hit 
    end
  end
  best_aln.each_value { |val| yield  val }
end
  end
end


class Bio::Blat::Report::Hit
  def covered
    match + mismatch
  end
  def query_percentage_covered
    covered * 100.0 / query_len.to_f
  end
  def target_percentage_covered
    covered * 100.0 / target_len.to_f
  end
end