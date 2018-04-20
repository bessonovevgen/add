﻿//////////////////////////////////////////////////////////////////////////
//
// LOGOS: вывод в файл
//
//////////////////////////////////////////////////////////////////////////

Перем ПутьКФайлуПолный Экспорт;// в эту переменную будет установлен правильный клиентский путь к текущему файлу

// { Plugin interface
Функция ОписаниеПлагина(ВозможныеТипыПлагинов) Экспорт
	Результат = Новый Структура;
	Результат.Вставить("Тип", ВозможныеТипыПлагинов.Утилита);
	Результат.Вставить("Идентификатор", Метаданные().Имя);
	Результат.Вставить("Представление", "Вывод в лог-файл");
	
	Возврат Новый ФиксированнаяСтруктура(Результат);
КонецФункции

Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
КонецПроцедуры
// } Plugin interface

// { API

Процедура ОткрытьФайл(Знач Путь, Знач КодировкаФайла = "utf-8", Знач Добавлять = Истина) Экспорт
	ПутьФайла = Путь;
	Кодировка = КодировкаФайла;
	
	мФайлЛога = Новый ЗаписьТекста(ПутьФайла, Кодировка,,Добавлять);
	мФайлЛога.Закрыть();
КонецПроцедуры

Процедура Вывести(Знач Сообщение) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ПутьФайла) Тогда
		ВызватьИсключение "Не указано имя лог-файла в параметре <ИмяФайлаЛогВыполненияСценариев>";
	КонецЕсли;	 
	
	Попытка
		мФайлЛога = Новый ЗаписьТекста(ПутьФайла, Кодировка, , Истина);
		мФайлЛога.ЗаписатьСтроку(Сообщение);
		мФайлЛога.Закрыть();
	Исключение
		Сообщить(ОписаниеОшибки());
	КонецПопытки;
	
КонецПроцедуры

// } API
