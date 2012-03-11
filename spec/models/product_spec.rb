require 'spec_helper'

describe Product do
  
  it "should have title" do
    product = Factory.build(:product, title: nil)
    product.should_not be_valid
  end

  it "should have unique title" do
    product = Factory.create(:product, title: 'Fallout 33')
    product2 = Factory.build(:product, title: 'Fallout 33')
    product2.should_not be_valid
  end

  it "should have valid image format" do
    product = Factory.build(:product, image_url: 'best.jpg')
    product.should be_valid
    product2 = Factory.build(:product, image_url: 'super.doc')
    product2.should_not be_valid
  end
end
