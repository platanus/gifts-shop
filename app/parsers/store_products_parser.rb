class StoreProductsParser < Parxer::CsvParser
  column(:name, name: "Title") do
    validate(:presence)
  end
  column(:image, name: "Image")
  column(:price, name: "Price") do
    validate(:presence)
    format_with(:number, float: true)
  end
  column(:link, name: "Link") do
    validate(:presence)
  end
end
