defmodule ExAzure.UtilsTest do
  use ExUnit.Case

  test "normalize arguments to list" do
    args = [
        "uploads",
        "arctest/uploads/profile.jpg",
        <<255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 1, 0>>,
        [
          acl: :public_read, content_type: "image/gif",
          content_disposition: "attachment; filename=abc.jpg"
        ]
      ]

    assert ExAzure.Utils.normalize_to_charlist(args) == [
        'uploads',
        'arctest/uploads/profile.jpg',
        <<255, 216, 255, 224, 0, 16, 74, 70, 73, 70, 0, 1, 1, 0, 0, 1, 0>>,
        [
          acl: :public_read, content_type: 'image/gif',
          content_disposition: 'attachment; filename=abc.jpg'
        ]
      ]
  end
end
