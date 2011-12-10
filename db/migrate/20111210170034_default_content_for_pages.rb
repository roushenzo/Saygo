class DefaultContentForPages < ActiveRecord::Migration
  def up
    str = %Q{
      <div class="clear img-bottom">
        <img src="http://upload.wikimedia.org/wikipedia/commons/thumb/5/54/Ko_Mak.jpg/250px-Ko_Mak.jpg" alt="Новый рисунок должен быть здесь"
          class="img-indent"></img>
          Писать текст сюда, а слева - рисунок. Достаточно просто перетащить его с рабочего стола ужерживаю клавишу SHIFT.
          Текущий рисунок можно удалить
      </div>Описание<p class="indent-top-bottom">Описание</p>Описание
    }
    # change_column_default :pages, :content, str
    change_column_default :pages, :content, str
  end

  def down
    change_column_default :pages, :content, nil
  end
end
