class UserRole < EnumerateIt::Base
  associate_values(
    :ordinary,
    :librarian
  )
end