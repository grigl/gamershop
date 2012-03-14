class Admin::ProductsController < Admin::AdminController

  def index
    @title = 'Menage products'
    @products = Product.page(params[:page]).per_page(30).order('title')
  end

  def new
    @title = 'Create new product'
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])

    if @product.save
      redirect_to products_path, notice: "product was sucessfully created"
    else
      render :new
    end
  end

  def edit
    @title = 'Edit product'
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      redirect_to products_path, notice: "product was sucessfully updated"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path, notice: "product was sucessfully deleted"
  end
end
