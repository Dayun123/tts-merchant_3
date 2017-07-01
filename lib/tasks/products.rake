namespace :products do
  desc "Seeds products, brands, and categories."
  task seed_products: :environment do

    # Clear out the DB before populating
    Product.destroy_all
    Category.destroy_all
    Brand.destroy_all

    # Destroy all images in the pics folder
    sh "rm -f ./pics/*"

    # Will append each image with a number so that I don't have to come up with unique names or worry about using Faker for these.
    image_num = 0

    # Will create 30 products when all is said and done (5 * 3 * 2)
    5.times do
      cat = Category.create(name: Faker::Book.unique.genre)
      3.times do
        brand = Brand.create(name: Faker::Commerce.unique.department)
        2.times do
          name = Faker::Commerce.unique.product_name
          # If we don't pass a number to rand, it gives us a float, so multiply by 100 and we should get a valid price, you can do this with Faker as well.
          price = rand * 100
          quantity = rand(10) + 1
          description = Faker::Lorem.paragraph
          # I have a directory in the merchant root called pics, that is where wget will store the images.
          image_path_from_app_root = "pics/image_#{image_num}.jpg"
          image_num += 1
          # runs the shell command wget to pull in a random image from lorempixel and names the image "image_(num).jpg", where num increases by 1 each time through the loop.
          sh "wget http://lorempixel.com/400/200/ -O #{image_path_from_app_root}"
          # If you don't have wget, comment the line above out and uncomment this line to use curl!
          #sh "curl http://lorempixel.com/400/200/ > #{image_path_from_app_root}"
          # Uses the absolute path on the filesystem to locate the image.
          full_image_path = Rails.root.to_s + "/" + image_path_from_app_root
          # Using File.new let's paperclip get in on the action and allows it to store the image in the apps public/system directory so we can use it on our pages. This will create the thumb, medium, and original sizes, super cool!
          avatar = File.new(full_image_path)
          # Since a product belongs_to a category, we can create it from the category associated with this brand, and the product will know that it belongs to this category. We have to pass the brand_id so that the product knows which brand it belongs to though.
          cat.products.create(name: name, price: price, quantity: quantity, description: description, brand_id: brand.id, avatar: avatar)
        end
      end
    end
    p "Finished seeding!"
  end
end
