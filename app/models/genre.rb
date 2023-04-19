class Genre < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: 'C' },
    { id: 2, name: 'Java' },
    { id: 3, name: 'Python' },
    { id: 4, name: 'Ruby' },
    { id: 5, name: 'PHP' },
    { id: 6, name: 'JavaScript' },
    { id: 7, name: 'Go' },
    { id: 8, name: 'Swift' },
    { id: 9, name: 'Perl' },
    { id: 10, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :sheets
end
