class Category < ActiveRecord::Base

    has_many :items
    validates_uniqueness_of :name

    def self.search(query)
      if !query.to_s.strip.empty?
         tokens = query.split.collect {|c| "%#{c.downcase}%"}
         find_by_sql(["select s.* from categories s where #{ (["(lower(s.name) like ? or lower(s.id) like ?)"] * tokens.size).join(" and ") } order by s.id desc", *(tokens * 2).sort])
      else
         []
      end
  end

end
