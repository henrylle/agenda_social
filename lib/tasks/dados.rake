require 'faker'
require 'down'

namespace :dados do
  desc 'Gerar posts fake'
  task popular_posts: :environment do
    spinner = pega_spinner 'Apagando banco...'
    `rails db:drop`
    spinner.success('Finalizado')

    spinner = pega_spinner 'Criando banco...'
    `rails db:create`
    spinner.success('Finalizado')

    spinner = pega_spinner 'Rodando migrates...'
    `rails db:migrate`
    spinner.success('Finalizado')

    spinner = pega_spinner 'Populando banco com locais de destino...'
    cadastrar_locais_destino
    spinner.success('Finalizado')

    spinners = TTY::Spinner::Multi.new('[:spinner] Populando banco com posts...')
    cadastrar_posts_com_spinner 10, 2, spinners
  end

  task popular_imagens: :environment do
    popular_imagens 5
  end

  def popular_imagens(total_itens)
    spinner = pega_spinner "Baixando e populando #{total_itens} imagens no post..."
    posts_sem_imagem = Post
                       .left_joins(:url_photo_attachment).group(:id).having('count(active_storage_attachments)=0')
                       .take(total_itens)
    posts_sem_imagem.each do |post|
      post.url_photo.attach(io: File.open(baixa_imagem_random), filename: "#{SecureRandom.uuid}.jpg")
    end
    spinner.success('Finalizado')
  end

  def pega_spinner(msg)
    spinner = TTY::Spinner.new("[:spinner] #{msg}", format: :pulse_2)
    spinner.auto_spin
    spinner
  end

  private

  def cadastrar_locais_destino
    destination_posts = [
      {
        name: 'Facebook',
        link: 'https://www.facebook.com/'
      },
      {
        name: 'Instagram',
        link: 'https://www.instagram.com/'
      },
      {
        name: 'Twitter',
        link: 'https://twitter.com/home'
      },
      {
        name: 'Linkedin',
        link: 'https://www.linkedin.com/'
      }
    ]
    destination_posts.each do |dp|
      DestinationPost.find_or_create_by!(dp)
    end
  end

  def cadastrar_posts(total_posts)
    (1..total_posts).each do |_j|
      post = {
        name: Faker::Lorem.sentence(word_count: 2),
        title: Faker::Lorem.sentence,
        content: Faker::Lorem.paragraphs(number: 2).join,
        post_date: Faker::Date.between(from: Date.today, to: 10.days.from_now),
        destination_post: DestinationPost.order(Arel.sql('RANDOM()')).first
      }
      p = Post.new(post)
      p.save!
    end
  end

  def baixa_imagem_random
    tempfile = Down.download("#{Faker::LoremFlickr.image(size: '150x180',
                                                         search_terms: ['sports'])}?random=#{rand(1..1000)}")
    tempfile.path
  end

  def cadastrar_posts_com_spinner(total_posts, total_iteracoes, spinners)
    sp = Array.new(total_iteracoes)

    (1..total_iteracoes).each do |i|
      sp[i] = spinners.register "[:spinner] gerando #{total_posts} posts"
      sp[i].auto_spin
    end
    (1..total_iteracoes).each do |i|
      cadastrar_posts total_posts
      sp[i].success
    end

    spinners.success if spinners.present?
  end
end
