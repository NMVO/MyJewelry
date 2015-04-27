require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:name].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
  end

  test "product price must be positive" do
    product = Product.new(name:       "My Book Title",
                          description: "yyy")
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], 
      product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(name:       "My Book Title",
                description: "yyy",
                price:       1)
  end

  test "product is not valid without a unique title" do
    product = Product.new(name:       products(:ruby).name,
                          description: "yyy", 
                          price:       1)

    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:name]
  end

  test "product is not valid without a unique title - i18n" do
    product = Product.new(name:       products(:ruby).name,
                          description: "yyy", 
                          price:       1)

    assert product.invalid?
    assert_equal [I18n.translate('errors.messages.taken')],
                 product.errors[:name]
  end
  
end
