
class Account < ActiveRecord::Base
  #types
  GROUP='G'
  HEAD='H'
  ACCOUNT='A'
  
  #category
  ASSET='A'
  LIABILITY='L'
  EQUITY='Q'
  EXPENSE='E'
  INCOME='I'

  validates_uniqueness_of :code
  validates_presence_of :description
  validates_inclusion_of :tipo, :in=>[GROUP,HEAD,ACCOUNT]
  validates_inclusion_of :category, :in=>[ASSET,LIABILITY,EQUITY,EXPENSE,INCOME]
  validates_exclusion_of :customer_vendor, :in => %w( C V ), :if => Proc.new { |c| c.tipo!=Account::HEAD },
    :message=>"can be set only to a head account (parent must be a group)"
   
  def initialize(*args)
    super
    set_tipo_from_parent_tipo
  end   
     
  def to_s
    "#{format_code} - #{description}"
  end
  
  def format_code
    sCod=code.to_s
    return sCod if sCod.size!=6
    if tipo==ACCOUNT
      sCod[0..0]+"."+sCod[1..2]+"."+sCod[3..5]
    else
      sCod[0..2]
    end
  end
  
  def balance
    debit.to_f-credit.to_f
  end
  
  def add_child(child_code,child_desc)
    first_free_child_code=find_free_child_code(child_code)
    c=Account.new(:code=>first_free_child_code,:description=>child_desc,:category=>self.category,:parent_id=>self.id)
    c.save
    c
  end
        
  private
  
  def find_free_child_code(start_code)
    new_code=code.to_i+start_code.to_i
    unless Account.find_by_code(new_code).nil?
      codes_array=Account.find :all, :conditions=>"code>'#{code}'",:select=>'code'
      new_code=code.to_i+1
      while codes_array.detect {|account| account.code.to_i==new_code}.nil? == false
        new_code+=1
      end
    end 
    new_code
  end    
  
  def set_tipo_from_parent_tipo
    unless parent_id.nil?
      unless Account.exists?(parent_id)
        raise "Parent not found"
      end
      parent=Account.find(parent_id)
      self.tipo=Account::HEAD if parent.tipo==Account::GROUP
      self.tipo=Account::ACCOUNT if parent.tipo==Account::HEAD
      return
    end
    self.tipo=Account::GROUP
  end
    
end
