FactoryGirl.define do
  factory :gallery do
    title {FFaker::Book.title}
    summary {FFaker::Book.description}
    user nil
    main_image {FFaker::Book.cover}
  end
end
