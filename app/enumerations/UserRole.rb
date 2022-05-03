class UserRole < EnumerateIt::Base
  associate_values(
    :reader,
    :librarian
  )
end