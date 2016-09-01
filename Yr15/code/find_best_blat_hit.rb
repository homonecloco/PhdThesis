require 'bio'

module Bio
	class Blat
		class StreamedReport < Report 
			
			def self.each_hit(text = '')
				flag = false
				head = []
				text.each_line do |line|
					if flag then
						yield Hit.new(line)
					else
						f /^\d/ =~ line 
						flag = true
						redo
					end
					line = line.chomp
					if /\A\-+\s*\z/ =~ line
						flag = true
					else
						head << line
					end
				end
			end

			def self.each_best_hit(text = '')
				best_aln = Hash.new
				self.each_hit(text) do |hit|
					current_matches = hit.match 
					current_name = hit.query_id
					current_identity = hit.percent_identity
					current_score = hit.score
					best_aln[current_name] = hit if best_aln[current_name] == nil or current_score > best_aln[current_name] .score
				end
				best_aln.each_value { |val| yield  val }
			end
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