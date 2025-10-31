# flutter_to_do

## Getting Started

UI ← пользователь вводит текст
  ↓
Пользователь нажимает кнопку "Добавить"
  ↓
UI создает Event с данными
  ↓
AddTask(title: "Купить хлеб")  ← Event содержит данные!
  ↓
BLoC получает Event
  ↓
BLoC берёт data из Event (event.title)
  ↓
BLoC отправляет в Repository
  ↓
Repository сохраняет в Hive (БД)