Шпаргалка по использованным приёмам в MongoDB.

---

### 1. Ссылки на поля vs строки

* `"$field"` → значение поля
* `"field"` → строка

Пример:

```json
{ $expr: { $lt: ["$a", "$b"] } }
```

---

### 2. Фильтрация (`$match`)

* простое равенство:

```json
{ year: 2015 }
```

* тип поля:

```json
{ "imdb.rating": { $type: "number" } }
```

* доступ к вложенным:

```json
{ "result.0.awards.wins": { $gt: 100 } }
```

---

### 3. `$lookup` (join)

```json
{
  $lookup: {
    from: "movies",
    localField: "movie_id",
    foreignField: "_id",
    as: "result"
  }
}
```

---

### 4. Работа с массивами

* первый элемент:

```json
{ $arrayElemAt: ["$arr", 0] }
```

* проекция поля из массива объектов:

```json
"$result.title"  // массив title
```

---

### 5. `$project`

* включить:

```json
{ field: 1 }
```

* переименовать:

```json
{ newName: "$oldName" }
```

* вычислить:

```json
{ diff: { $subtract: ["$a", "$b"] } }
```

* взять из массива:

```json
{
  title: { $arrayElemAt: ["$result.title", 0] }
}
```

---

### 6. `$group` (агрегации)

```json
{
  _id: "$field",
  count: { $sum: 1 },
  avg: { $avg: "$value" },
  list: { $push: "$something" }
}
```

---

### 7. Сортировка и лимит

```json
{ $sort: { count: -1 } }
{ $limit: 5 }
```

---

### 8. Приведение типов

```json
{ $toString: "$year" }
{ $toInt: "$year" }
```

---

### 9. Очистка грязных данных (regex)

```json
{
  $regexFind: {
    input: { $toString: "$year" },
    regex: "\\d{4}"
  }
}
```

достать результат:

```json
{
  $getField: {
    field: "match",
    input: <regexFind>
  }
}
```

---

### 10. `$set` / `$addFields`

Добавление/перезапись поля:

```json
{
  $set: {
    year: { $toInt: ... }
  }
}
```

---

### 11. Условия внутри `$expr`

```json
{
  $expr: {
    $and: [
      { $gt: [ { $size: "$arr" }, 0 ] },
      { $gt: [ "$field", 100 ] }
    ]
  }
}
```

---

### 12. Проверка массива

* пустой / не пустой:

```json
{ $size: "$arr" }
```

или проще:

```json
"arr.0": { $exists: true }
```

---

### 13. Процентили (top 20%)

```json
{
  $percentile: {
    input: "$imdb.rating",
    p: [0.8]
  }
}
```

---

### 14. `$facet` (параллельные пайплайны)

```json
{
  $facet: {
    max: [ { $sort: { year: -1 } }, { $limit: 1 } ],
    min: [ { $sort: { year: 1 } }, { $limit: 1 } ]
  }
}
```

---

### 15. Ключевые ошибки

* забыли `$stage` (`$lookup`, `$match` и т.д.)
* забыли кавычки у строк
* использовали `$` в имени поля
* передали объект вместо выражения (`{ "$field" }`)
* перепутали оператор (`$exp` вместо `$round`)

---

Это базовый набор, покрывающий:

* фильтрацию
* join
* агрегацию
* работу с массивами
* очистку данных
* вычисления
* оконные и статистические операции
