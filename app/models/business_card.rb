class BusinessCard < ActiveRecord::Base
  belongs_to :print_method
  belongs_to :ink_color
  belongs_to :bleed
  belongs_to :raised_ink
  belongs_to :dimension
  belongs_to :paper_type
  belongs_to :coating
  belongs_to :quantity
  belongs_to :box_count
  belongs_to :metal

  validates :price, :cost, presence: true
  validates_numericality_of :price, greater_than: 0, on: :create
  validates_numericality_of :cost, greater_than: 0, on: :create

  def self.search(q)
    result = where("print_method_id = ? AND ink_color_id = ? AND bleed_id = ? AND raised_ink_id = ? AND dimension_id = ? AND paper_type_id = ? AND coating_id = ? AND quantity_id = ? AND box_count_id = ? AND metal_id = ?", q['print_method_id'], q['ink_color_id'], q['bleed_id'], q['raised_ink_id'], q['dimension_id'], q['paper_type_id'], q['coating_id'], q['quantity_id'], q['box_count_id'], q['metal_id'])
  end


  def self.similar_products(target_params)
    same_print_method =  BusinessCard.where(print_method_id: target_params['print_method_id'])

    target_ink_obj = InkColor.find(target_params['ink_color_id'])
    target_bleed_obj = Bleed.find(target_params['bleed_id'])
    target_raised_obj = RaisedInk.find(target_params['raised_ink_id'])
    target_dimension_obj = Dimension.find(target_params['dimension_id'])
    target_coating_obj = Coating.find(target_params['coating_id'])
    target_metal_obj = Metal.find(target_params['metal_id'])

    if target_metal_obj.front != "none" || target_metal_obj.back != "none"
      same_print_method =  BusinessCard.where(metal_id: target_params['metal_id'])
    end

    if target_bleed_obj.front == false && target_bleed_obj.back == false
      same_print_method = same_print_method.map {|obj| obj if obj.bleed.front == false && obj.bleed.back == false}.compact
    elsif target_bleed_obj.front || target_bleed_obj.back
      same_print_method = same_print_method.map {|obj| obj if obj.bleed.front || obj.bleed.back}.compact
    end


    target_bc = {"ink_color" => {"front" => "#{target_ink_obj.front}",   "back" => "#{target_ink_obj.back}"},
                 "bleed"     => {"front" => "#{target_bleed_obj.front}", "back" => "#{target_bleed_obj.back}"},
                 "raised_ink"     => {"front" => "#{target_raised_obj.front}", "back" => "#{target_raised_obj.back}"},
                 "dimension"     => {"width" => "#{target_dimension_obj.width}", "height" => "#{target_dimension_obj.height}"},
                 "coating"     => {"front" => "#{target_coating_obj.front}", "back" => "#{target_coating_obj.back}"}
                  }

    business_card_scores = []

    if same_print_method.count > 0
      same_print_method.each do |bc|
        business_card_scores << [bc.id, self.generate_score(bc, target_bc)]
      end
      results = business_card_scores.sort_by{ |bc| bc[1] }
      results.reverse
    end
  end



  private


  def self.generate_score(bc, target)
    # if bc.print_method.print_method.downcase == "pantone offset"
    #   generate_pantone_offset_score(bc, target)
    # elsif bc.print_method.print_method.downcase == "cmyk offset"
    #   generate_cmyk_offset_score(bc, target)
    # elsif bc.print_method.print_method.downcase == "letterpress"
    #   generate_letterpress_score(bc, target)
    # else
    #   generate_digital_score(bc, target)
    # end
    generate_pantone_offset_score(bc, target)
  end

  def self.generate_pantone_offset_score(bc, target)
    score = []
    score << self.pantone_ink_color_score(bc, target)
    score << self.pantone_bleed_score(bc) if target["bleed"]["front"] == "true" || target["bleed"]["back"] == "true"
    score << self.pantone_raised_ink_score(bc, target) if target["raised_ink"]["front"].to_i > 0 || target["raised_ink"]["back"].to_i > 0
    score << self.pantone_dimension_score(bc, target)
    score << self.pantone_coating_score(bc, target) if target["coating"]["front"] != "none" || target["coating"]["back"] != "none"
    sum = score.inject(:+)
  end

  def generate_cmyk_offset_score(bc, target)
  end

  def generate_letterpress_score(bc, target)
  end

  def generate_digital_score(bc, target)
  end

  def self.pantone_ink_color_score(b, t)
    b_colors = b.ink_color.front + b.ink_color.back
    t_colors = t["ink_color"]["front"].to_i + t["ink_color"]["back"].to_i
    diff = nil
    pic_score = nil

    if b_colors > t_colors
      diff = b_colors - t_colors
    else
      diff = t_colors - b_colors
    end

    case diff
    when 0
      pic_score = 15
    when 1
      pic_score = 10
    when 2
      pic_score = 5
    when 3..9
      pic_score = 3
    else
      pic_score = 0
    end
      
    pic_score
  end

  def self.pantone_bleed_score(b)
    pb_score = 0

    puts "*****************************"
    puts "REACHED_BLEED_SCORE_METHOD"
    puts "*****************************"
    if b.bleed.front == true || b.bleed.back == true
      pb_score = 15
    else
      pb_score = 0
    end
  end

  def self.pantone_raised_ink_score(b, t)
    b_colors = b.raised_ink.front + b.raised_ink.back
    t_colors = t["raised_ink"]["front"].to_i + t["raised_ink"]["back"].to_i
    diff = nil
    pri_score = nil

    if b_colors > t_colors
      diff = b_colors - t_colors
    else
      diff = t_colors - b_colors
    end

    case diff
    when 0
      pri_score = 15
    when 1
      pri_score = 10
    when 2
      pri_score = 5
    when 3..9
      pri_score = 3
    else
      pri_score = 0
    end
      
    pri_score
  end

  def self.pantone_dimension_score(b, t)
    b_size = b.dimension.width.to_i + b.dimension.height.to_i
    t_size = t["dimension"]["width"].to_i + t["dimension"]["height"].to_i
    diff = nil
    pd_score = nil

    if b_size > t_size
      diff = b_size - t_size
    else
      diff = t_size - b_size
    end

    case diff
    when 0
      pd_score = 15
    when 1
      pd_score = 10
    when 2
      pd_score = 5
    when 3..9
      pd_score = 3
    else
      pd_score = 0
    end
      
    pd_score
  end

  def self.pantone_coating_score(b, t)
    if b.coating.front == t["coating"]["front"]
      pc_score = 15
    elsif b.coating.back == t["coating"]["back"]
      pc_score = 15
    else
      pc_score = 0
    end
  end

end
















