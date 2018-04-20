﻿&НаКлиенте
Перем КонтекстЯдра;

// { Plugin interface

&НаКлиенте
Процедура Инициализация(КонтекстЯдраПараметр) Экспорт
	КонтекстЯдра = КонтекстЯдраПараметр;
КонецПроцедуры

&НаКлиенте
Функция ОписаниеПлагина(ВозможныеТипыПлагинов) Экспорт
	Возврат ОписаниеПлагинаНаСервере(ВозможныеТипыПлагинов);
КонецФункции

&НаСервере
Функция ОписаниеПлагинаНаСервере(ВозможныеТипыПлагинов)
	Возврат Объект().ОписаниеПлагина(ВозможныеТипыПлагинов);
КонецФункции
// } Plugin interface

// { Методы генерации тестовых данных

&НаКлиенте
Функция СоздатьДанныеПоТабличномуДокументу(ТабличныйДокумент, РежимыЗагрузкиИлиИмяКолонкиЗамещения = Неопределено, ИмяКолонкиЗамещения = Неопределено, ВозвращатьДанные = Истина) Экспорт
	Данные = СоздатьДанныеПоТабличномуДокументуСервер(ТабличныйДокумент, РежимыЗагрузкиИлиИмяКолонкиЗамещения, ИмяКолонкиЗамещения, ВозвращатьДанные);
	Возврат Данные;
КонецФункции

// удаляет созданные элементы (Справочники, Документы, Пользователи ИБ), регистры сведений не чистит - есть тесты
&НаКлиенте
Функция УдалитьСозданныеДанные(Данные) Экспорт
	КоличествоУдаленных = УдалитьСозданныеДанныеСервер(Данные);
	Возврат КоличествоУдаленных;
КонецФункции

&НаСервере
Функция СоздатьДанныеПоТабличномуДокументуСервер(ТабличныйДокумент, РежимыЗагрузкиИлиИмяКолонкиЗамещения, ИмяКолонкиЗамещения, ВозвращатьДанные)
	Данные = Объект().СоздатьДанныеПоТабличномуДокументу(ТабличныйДокумент, РежимыЗагрузкиИлиИмяКолонкиЗамещения, ИмяКолонкиЗамещения, Истина);
	// В данных могут быть какие-нибудь данные, например, наборы записей регистров, которые нельзя передать на клиент
	Если ВозвращатьДанные Тогда
		Возврат Данные;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
КонецФункции

&НаСервере
Функция УдалитьСозданныеДанныеСервер(Знач Данные)
	Возврат Объект().УдалитьСозданныеДанные(Данные);
КонецФункции

//}

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ЭЛЕМЕНТОВ ШАПКИ ФОРМЫ

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ ТаблицаДанных

&НаКлиенте
Процедура ТаблицаДанныхСсылкаПриИзменении(Элемент)
	ТаблицаДанныхСсылкаПриИзмененииСервер(Элементы.ТаблицаДанных.ТекущаяСтрока);
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ КОМАНД ФОРМЫ

&НаКлиенте
Процедура СоздатьМакетДанных(Команда)
	ПанельИсточников = Элементы.ГруппаСтраницы;
	Если ПанельИсточников.ТекущаяСтраница = ПанельИсточников.ПодчиненныеЭлементы.ГруппаМетаданные Тогда
		КоманднаяПанель1СоздатьМакетДанныхПоМетаданным();
	ИначеЕсли ПанельИсточников.ТекущаяСтраница = ПанельИсточников.ПодчиненныеЭлементы.ГруппаТаблицаДанных Тогда
		КоманднаяПанель1СоздатьМакетДанныхПоТаблицеДанных();
	ИначеЕсли ПанельИсточников.ТекущаяСтраница = ПанельИсточников.ПодчиненныеЭлементы.ГруппаПользователиИБ Тогда
		КоманднаяПанель1СоздатьМакетДанныхДляПользователейИБ();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура КоманднаяПанель1СоздатьМакетДанныхПоТаблицеДанных()
	Если ПроверитьЗаполнение() Тогда
		НовыйМакет = СоздатьМакетДанныхПоТаблицеДанныхСервер();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура КоманднаяПанель1СоздатьМакетДанныхПоМетаданным()
	
	СохранитьОтображениеДерева(Объект.ДеревоМетаданных.ПолучитьЭлементы());
	НовыйМакет = СоздатьМакетДанныхПоМетаданнымСервер();
	ВосстановитьОтображениеДерева(Объект.ДеревоМетаданных.ПолучитьЭлементы());
	
КонецПроцедуры

&НаКлиенте
Процедура КоманднаяПанель1СоздатьМакетДанныхДляПользователейИБ()
	
	МассивИменПользователей = Новый Массив;
	Для Каждого ИдентификаторСтроки Из Элементы.ПользователиИнфБазы.ВыделенныеСтроки Цикл
		Строка = Объект.ПользователиИБ.НайтиПоИдентификатору(ИдентификаторСтроки);
		МассивИменПользователей.Добавить(Строка.Имя);
	КонецЦикла;
	НовыйМакет = СоздатьМакетДанныхПоПользователямИБСервер(МассивИменПользователей);
	
КонецПроцедуры

&НаКлиенте
Процедура ПротестироватьЗагрузкуМакета(Команда)
	ПроверитьЗагрузкуМакетаСервер(Макет);
КонецПроцедуры

&НаКлиенте
Процедура СохранитьМакетДанныхВФайл(Команда)
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	ДиалогВыбораФайла.ПолноеИмяФайла = "";
	ДиалогВыбораФайла.Фильтр = "Табличный документ (*.mxl)|*.mxl|Все файлы (*.*)|*.*";
	ДиалогВыбораФайла.Заголовок = "Выберите файл";
	Если Не ДиалогВыбораФайла.Выбрать() Тогда
		Возврат;
	КонецЕсли;
	
	Макет.Записать(ДиалогВыбораФайла.ПолноеИмяФайла);
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьТаблицуДанных(Команда)
	Объект.ТаблицаДанных.Очистить();
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// СЛУЖЕБНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ

&НаСервере
Функция Объект()
	Возврат РеквизитФормыВЗначение("Объект");
КонецФункции

&НаСервере
Процедура ТаблицаДанныхСсылкаПриИзмененииСервер(ИдентификаторСтрокиДанных)
	ЭлементДанных = Объект.ТаблицаДанных.НайтиПоИдентификатору(ИдентификаторСтрокиДанных);
	Объект().ПриИзмененииСсылки(ЭлементДанных);
КонецПроцедуры

&НаСервере
Функция СоздатьМакетДанныхПоТаблицеДанныхСервер()
	Возврат Объект().СоздатьМакетДанныхПоТаблицеДанных(Макет);
КонецФункции

&НаСервере
Функция СоздатьМакетДанныхПоМетаданнымСервер()
	
	ОбъектНаСервере = Объект();
	ЗаполнитьДеревоМетаданныхНаСервере(ОбъектНаСервере);
	НовыйМакет = ОбъектНаСервере.СоздатьМакетДанныхПоМетаданным(Макет);
	ЗначениеВРеквизитФормы(ОбъектНаСервере.ДеревоМетаданных, "Объект.ДеревоМетаданных");
	
	Возврат НовыйМакет;
	
КонецФункции

Функция СоздатьМакетДанныхПоПользователямИБСервер(МассивИменПользователей)
	Возврат Объект().СоздатьМакетДанныхПоПользователямИБ(Макет, МассивИменПользователей);
КонецФункции

&НаСервере
Процедура ПроверитьЗагрузкуМакетаСервер(ТабличныйДокумент)
	Объект().ПроверитьЗагрузкуМакета(ТабличныйДокумент);
КонецПроцедуры




&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ОбъектНаСервере = Объект();
	ЭтаФорма.Заголовок = ОбъектНаСервере.ЗаголовокФормы();
	
	ОбъектНаСервере.НачальнаяИнициализация();
	ЗначениеВРеквизитФормы(ОбъектНаСервере.ДеревоМетаданных, "Объект.ДеревоМетаданных");
	ЗначениеВРеквизитФормы(ОбъектНаСервере.ПользователиИБ, "Объект.ПользователиИБ");

	ОбъектНаСервере.СписокВыбора_РежимПоиска(Элементы.ТаблицаДанныхРежимПоиска.СписокВыбора);
	ОбъектНаСервере.СписокВыбора_РежимСоздания(Элементы.ТаблицаДанныхРежимСоздания.СписокВыбора);
	
	Объект.ВыгружатьСсылку = Истина;
	
	//Объект.СвязьПоГуид = Истина;
	Объект.ОбменДанными = Истина;
	
	Элементы.ФормаДополнительныеСвойства.Пометка = Ложь;
	Элементы.ДополнительныеСвойства.Видимость = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	//Отказ = (Вопрос("Вы действительно хотите закрыть обработку?", РежимДиалогаВопрос.ДаНет,,,"Подтвердите выход") = КодВозвратаДиалога.Нет);
КонецПроцедуры

&НаКлиенте
Процедура ПересчитатьВыгружаемыеПоСсылке(Команда)
	
	Состояние(Нстр("ru = 'Выполняется поиск объектов метаданных, которые могут быть выгружены по ссылкам...'"));
	СохранитьОтображениеДерева(Объект.ДеревоМетаданных.ПолучитьЭлементы());
	ПересчитатьВыгружаемыеПоСсылкеНаСервере();
	ВосстановитьОтображениеДерева(Объект.ДеревоМетаданных.ПолучитьЭлементы());
	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьОтображениеДерева(СтрокиДерева)
	
	Для Каждого Строка Из СтрокиДерева Цикл
		
		ИдентификаторСтроки=Строка.ПолучитьИдентификатор();
		Строка.Развернут = Элементы.ДеревоМетаданных.Развернут(ИдентификаторСтроки);
		
		СохранитьОтображениеДерева(Строка.ПолучитьЭлементы());
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ВосстановитьОтображениеДерева(СтрокиДерева)
	
	Для Каждого Строка Из СтрокиДерева Цикл
		
		ИдентификаторСтроки=Строка.ПолучитьИдентификатор();
		Если Строка.Развернут Тогда
			Элементы.ДеревоМетаданных.Развернуть(ИдентификаторСтроки);
		КонецЕсли;
		
		ВосстановитьОтображениеДерева(Строка.ПолучитьЭлементы());
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ПересчитатьВыгружаемыеПоСсылкеНаСервере()
	
	ОбъектНаСервере = Объект();
	ЗаполнитьДеревоМетаданныхНаСервере(ОбъектНаСервере);
	ОбъектНаСервере.СоставВыгрузки(Истина);
	ЗначениеВРеквизитФормы(ОбъектНаСервере.ДеревоМетаданных, "Объект.ДеревоМетаданных");
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДеревоМетаданныхНаСервере(ОбъектНаСервере)
	
	ДеревоМетаданных = РеквизитФормыВЗначение("Объект.ДеревоМетаданных");
	
	ОбъектНаСервере.НачальнаяИнициализация();
	
	ПроставитьПометкиВыгружаемыхДанных(ОбъектНаСервере.ДеревоМетаданных.Строки, ДеревоМетаданных.Строки);
	
КонецПроцедуры

&НаСервере
Процедура ПроставитьПометкиВыгружаемыхДанных(СтрокиИсходногоДерева, СтрокиЗаменяемогоДерева)
	
	КолонкаВыгружать = СтрокиЗаменяемогоДерева.ВыгрузитьКолонку("Выгружать");
	СтрокиИсходногоДерева.ЗагрузитьКолонку(КолонкаВыгружать, "Выгружать");
	
	КолонкаВыгружатьПриНеобходимости = СтрокиЗаменяемогоДерева.ВыгрузитьКолонку("ВыгружатьПриНеобходимости");
	СтрокиИсходногоДерева.ЗагрузитьКолонку(КолонкаВыгружатьПриНеобходимости, "ВыгружатьПриНеобходимости");
	
	КолонкаРазвернут = СтрокиЗаменяемогоДерева.ВыгрузитьКолонку("Развернут");
	СтрокиИсходногоДерева.ЗагрузитьКолонку(КолонкаРазвернут, "Развернут");
	
	КолонкаНастройкиКомпоновщика = СтрокиЗаменяемогоДерева.ВыгрузитьКолонку("НастройкиКомпоновщика");
	СтрокиИсходногоДерева.ЗагрузитьКолонку(КолонкаНастройкиКомпоновщика, "НастройкиКомпоновщика");
	
	КолонкаИспользоватьОтбор = СтрокиЗаменяемогоДерева.ВыгрузитьКолонку("ИспользоватьОтбор");
	СтрокиИсходногоДерева.ЗагрузитьКолонку(КолонкаИспользоватьОтбор, "ИспользоватьОтбор");
	
	Для Каждого СтрокаИсходногоДерева Из СтрокиИсходногоДерева Цикл
		
		ИндексСтроки = СтрокиИсходногоДерева.Индекс(СтрокаИсходногоДерева);
		СтрокаИзменяемогоДерева = СтрокиЗаменяемогоДерева.Получить(ИндексСтроки);
		
		ПроставитьПометкиВыгружаемыхДанных(СтрокаИсходногоДерева.Строки, СтрокаИзменяемогоДерева.Строки);
		
	КонецЦикла;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ ТАБЛИЦЫ ФОРМЫ ДеревоМетаданных

&НаКлиенте
Процедура ДеревоМетаданныхВыгружатьПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.ДеревоМетаданных.ТекущиеДанные;
	
	Если ТекущиеДанные.Выгружать = 2 Тогда
		ТекущиеДанные.Выгружать = 0;
	КонецЕсли;
	
	УстановитьПометкиПодчиненных(ТекущиеДанные, "Выгружать");
	УстановитьПометкиРодителей(ТекущиеДанные, "Выгружать");
	
	УровеньВыгрузкиПриИзменении(Элемент);	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоМетаданныхВыгружатьПриНеобходимостиПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.ДеревоМетаданных.ТекущиеДанные;
	
	Если ТекущиеДанные.ВыгружатьПриНеобходимости = 2 Тогда
		ТекущиеДанные.ВыгружатьПриНеобходимости = 0;
	КонецЕсли;
	
	УстановитьПометкиПодчиненных(ТекущиеДанные, "ВыгружатьПриНеобходимости");
	УстановитьПометкиРодителей(ТекущиеДанные, "ВыгружатьПриНеобходимости");
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПометкиПодчиненных(ТекСтрока, ИмяФлажка)
	
	Подчиненные = ТекСтрока.ПолучитьЭлементы();
	
	Если Подчиненные.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого Строка из Подчиненные Цикл
		
		Строка[ИмяФлажка] = ТекСтрока[ИмяФлажка];
		
		УстановитьПометкиПодчиненных(Строка, ИмяФлажка);
		
	КонецЦикла;
		
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПометкиРодителей(ТекСтрока, ИмяФлажка)
	
	Родитель = ТекСтрока.ПолучитьРодителя();
	Если Родитель = Неопределено Тогда
		Возврат;
	КонецЕсли; 
	
	ТекСостояние = Родитель[ИмяФлажка];
	
	НайденыВключенные  = Ложь;
	НайденыВыключенные = Ложь;
	
	Для Каждого Строка из Родитель.ПолучитьЭлементы() Цикл
		Если Строка[ИмяФлажка] = 0 Тогда
			НайденыВыключенные = Истина;
		ИначеЕсли Строка[ИмяФлажка] = 1
			ИЛИ Строка[ИмяФлажка] = 2 Тогда
			НайденыВключенные  = Истина;
		КонецЕсли; 
		Если НайденыВключенные И НайденыВыключенные Тогда
			Прервать;
		КонецЕсли; 
	КонецЦикла;
	
	Если НайденыВключенные И НайденыВыключенные Тогда
		Включить = 2;
	ИначеЕсли НайденыВключенные И (Не НайденыВыключенные) Тогда
		Включить = 1;
	ИначеЕсли (Не НайденыВключенные) И НайденыВыключенные Тогда
		Включить = 0;
	ИначеЕсли (Не НайденыВключенные) И (Не НайденыВыключенные) Тогда
		Включить = 2;
	КонецЕсли;
	
	Если Включить = ТекСостояние Тогда
		Возврат;
	Иначе
		Родитель[ИмяФлажка] = Включить;
		УстановитьПометкиРодителей(Родитель, ИмяФлажка);
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоМетаданныхПриАктивизацииСтроки(Элемент)
	
	ПодключитьОбработчикОжидания("ДеревоМетаданныхПриАктивизацииСтрокиОбработкаОжидания", 0.1, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ДеревоМетаданныхПриАктивизацииСтрокиОбработкаОжидания()
	
	ТекущаяСтрока = Элементы.ДеревоМетаданных.ТекущаяСтрока;
	Если ТекущаяСтрока = ДеревоМетаданныхПредыдущаяСтрока Тогда
		Возврат;
	КонецЕсли;
	ДеревоМетаданныхПредыдущаяСтрока = ТекущаяСтрока;
	
	НастроитьКомпоновщик();
	
КонецПроцедуры

// Служит для настройки построителя при отборе данных
//
// Параметры:
//
&НаКлиенте
Процедура НастроитьКомпоновщик()
	
	ТекущаяСтрока = Элементы.ДеревоМетаданных.ТекущиеДанные;
	
	Если ТекущаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ОпределитьПоСтрокеДереваДоступенПостроитель(ТекущаяСтрока) Тогда
		
		ДоступностьКомпоновщика = ЛОЖЬ;
		УдалитьОтборыКомпоновщика(Объект.КомпоновщикНастроекКомпоновкиДанных);
		
	Иначе
		
		Попытка
			
			НастроитьКомпоновщикНаСервере(Элементы.ДеревоМетаданных.ТекущаяСтрока);
			
			ДоступностьКомпоновщика = Истина;
			
		Исключение
			ДоступностьКомпоновщика = ЛОЖЬ;
			УдалитьОтборыКомпоновщика(Объект.КомпоновщикНастроекКомпоновкиДанных);
		КонецПопытки;
		
	КонецЕсли;
	
	Элементы.КомпоновщикОтбор.Доступность = ДоступностьКомпоновщика;
	//Элементы.КоманднаяПанельКомпоновщикОтбор.Доступность = ДоступностьКомпоновщика;
	
КонецПроцедуры

&НаКлиенте
Функция ОпределитьПоСтрокеДереваДоступенПостроитель(СтрокаДерева)
	
	Если СтрокаДерева.ПолучитьЭлементы().Количество() > 0 Тогда
		Возврат Ложь;
	Иначе
		Возврат Истина;
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура УдалитьОтборыКомпоновщика(Компоновщик)
	
	Компоновщик.Настройки.Отбор.Элементы.Очистить();
	
КонецПроцедуры

&НаСервере
Процедура НастроитьКомпоновщикНаСервере(ТекущаяСтрока)
	
	СтрокаДерева = Объект.ДеревоМетаданных.НайтиПоИдентификатору(ТекущаяСтрока);
	СхемаКомпоновкиДанных = Объект().ПодготовитьКомпоновщикДляВыгрузки(СтрокаДерева);
	АдресСхемы = ПоместитьВоВременноеХранилище(СхемаКомпоновкиДанных, УникальныйИдентификатор);
	Объект.КомпоновщикНастроекКомпоновкиДанных.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(АдресСхемы));
	Объект.КомпоновщикНастроекКомпоновкиДанных.ЗагрузитьНастройки(СхемаКомпоновкиДанных.НастройкиПоУмолчанию);
	
КонецПроцедуры // НастроитьКомпоновщикНаСервере()

&НаКлиенте
Процедура КомпоновщикОтборПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	
	ОбновитьНастройкиПостроителяВТаблицеДляВыгрузки();
	
КонецПроцедуры

&НаКлиенте
Процедура КомпоновщикОтборПослеУдаления(Элемент)
	
	ОбновитьНастройкиПостроителяВТаблицеДляВыгрузки();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьНастройкиПостроителяВТаблицеДляВыгрузки()
	
	ТекущаяСтрока = Элементы.ДеревоМетаданных.ТекущиеДанные;
	Если Объект.КомпоновщикНастроекКомпоновкиДанных.Настройки.Отбор.Элементы.Количество() > 0 Тогда
		
		ТекущаяСтрока.НастройкиКомпоновщика = Объект.КомпоновщикНастроекКомпоновкиДанных.Настройки.Отбор;//Объект.КомпоновщикНастроекКомпоновкиДанных.ПолучитьНастройки();
		ТекущаяСтрока.ИспользоватьОтбор    = ИСТИНА;
		ТекущаяСтрока.Выгружать = Истина;
		
	Иначе
		
		ТекущаяСтрока.НастройкиКомпоновщика = Неопределено;
		ТекущаяСтрока.ИспользоватьОтбор    = ЛОЖЬ;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьРезультатОтбора(Команда)
	
	// показать выбранные записи
	Если Элементы.КомпоновщикОтбор.Доступность <> Истина
		ИЛИ Элементы.ДеревоМетаданных.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТабличныйДокумент = ПолучитьРезультатОтбораНаСервере();
	ТабличныйДокумент.Показать(НСтр("ru = 'Выбранные объекты'"));
	
КонецПроцедуры

&НаСервере
Функция ПолучитьРезультатОтбораНаСервере()
	
	СтрокаДерева = Объект.ДеревоМетаданных.НайтиПоИдентификатору(Элементы.ДеревоМетаданных.ТекущаяСтрока);
	ТабличныйДокумент = Объект().СформироватьОтчетПоОтобраннымДанным(СтрокаДерева);
	
	Возврат ТабличныйДокумент;
	
КонецФункции // ПолучитьРезультатОтбораНаСервере()

&НаКлиенте
Процедура ДополнительныеСвойства(Команда)
	Элементы.ФормаДополнительныеСвойства.Пометка = НЕ Элементы.ФормаДополнительныеСвойства.Пометка;
	Элементы.ДополнительныеСвойства.Видимость = Элементы.ФормаДополнительныеСвойства.Пометка;
КонецПроцедуры

&НаКлиенте
Процедура УровеньВыгрузкиПриИзменении(Элемент)
	Если Объект.УровеньВыгрузки = 0 Тогда
		СтрокаКонфигурации = Объект.ДеревоМетаданных.ПолучитьЭлементы()[0];
		СтрокаКонфигурации.ВыгружатьПриНеобходимости = 1;
		ДеревоМетаданныхВыгружатьПриНеобходимостиПриИзменении(Элемент);
	Иначе
		ПересчитатьВыгружаемыеПоСсылке(Элемент);
	КонецЕсли;
КонецПроцедуры

#Область НастройкиЗагрузкаВыгрузка

&НаКлиенте
Процедура СохранитьНастройки(Команда)
	Данные = СохранитьНастройкиСервер();
	
	Документ = новый ТекстовыйДокумент;
	Документ.УстановитьТекст(Данные);
	СохранениеНастроек = новый ОписаниеОповещения("СохранениеНастроек",ЭтотОбъект);
	Попытка
		Документ.НачатьЗапись(СохранениеНастроек,ПутьКФайлуНастроек,"UTF-8");
	Исключение
		Документ.Записать(ПутьКФайлуНастроек,"UTF-8");
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура СохранениеНастроек(Результат, ДополнительныеПараметры) Экспорт
	
	ОчиститьСообщения();
	
	Если Результат=Истина Тогда
		Сообщить("Файл записан успешно!");
	Иначе
		Сообщить("При сохранении файла настроек произошла ошибка!");	
	КонецЕсли;
	
КонецПроцедуры


&НаСервере
Функция СохранитьНастройкиСервер()
	
	Дерево = РеквизитФормыВЗначение("Объект.ДеревоМетаданных");
	Возврат ЗначениеВСтрокуВнутр(Дерево);
	
КонецФункции


&НаКлиенте
Процедура ЗагрузитьНастройки(Команда)
	
	ОчиститьСообщения();
	
	Документ = новый ТекстовыйДокумент;
	
	ЗагрузкаНастроек = новый ОписаниеОповещения("ЗагрузкаНастроек",ЭтотОбъект,Документ);
	Попытка
		Документ.НачатьЧтение(ЗагрузкаНастроек,ПутьКФайлуНастроек,"UTF-8");
	Исключение
		Документ.Прочитать(ПутьКФайлуНастроек,"UTF-8");
		Данные = Документ.ПолучитьТекст();
		ЗагрузитьНастройкиКлиент(Данные);
	КонецПопытки;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузкаНастроек(Документ) Экспорт
	
	Если Тип(Документ)=Тип("ТекстовыйДокумент") Тогда
		Данные = Документ.ПолучитьТекст();
		ЗагрузитьНастройкиКлиент(Данные);
	Иначе
		Сообщить("Произошла ошибка при загрузке настроек");
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьНастройкиКлиент(Данные)
	
	ЗагрузитьНастройкиСервер(Данные);
	Корень = Объект.ДеревоМетаданных.ПолучитьЭлементы();
	Если Корень.Количество()>0 Тогда  
		Элементы.ДеревоМетаданных.Развернуть(Корень[0].ПолучитьИдентификатор(),Истина);
	КонецЕсли;
	
КонецПроцедуры


&НаСервере
Процедура ЗагрузитьНастройкиСервер(Данные)
	
	Попытка
		Дерево = ЗначениеИзСтрокиВнутр(Данные);
		ЗначениеВРеквизитФормы(Дерево,"Объект.ДеревоМетаданных");
	Исключение
		Сообщить(ОписаниеОшибки());
		Возврат;
	КонецПопытки;  	
	
	Сообщить("Успешно!");
	
КонецПроцедуры


&НаКлиенте
Процедура ПутьКФайлуНастроекНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие); 
	Диалог.Заголовок = "Выберите файл"; 
	Диалог.ПолноеИмяФайла = ""; 
	Фильтр = "txt-файл (*.txt)|*.txt"; 
	Диалог.Фильтр = Фильтр; 
	Если ЗначениеЗаполнено(ПутьКФайлуНастроек) Тогда
		Диалог.Каталог = ПолучитьКаталогПоПутиФайла(ПутьКФайлуНастроек);
	КонецЕсли;
	Диалог.МножественныйВыбор = Ложь; 
	ВыборФайлаОткрытияФайлаНастроек = новый ОписаниеОповещения("ВыборФайлаОткрытияФайлаНастроек",ЭтотОбъект);
	Диалог.Показать(ВыборФайлаОткрытияФайлаНастроек);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборФайлаОткрытияФайлаНастроек(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныеФайлы <> Неопределено И ВыбранныеФайлы.Количество() > 0 Тогда
		ПутьКФайлуНастроек = ВыбранныеФайлы[0]; 
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Функция  ПолучитьКаталогПоПутиФайла(Знач ПутьКФайлу)
	Файл = новый Файл(ПутьКФайлу);
	Возврат Файл.Путь;	
КонецФункции


#КонецОбласти

#Область Настройки

&НаКлиенте
Процедура ТолькоВыбранные(Команда)
	
		
	ТолькоВыбранныеНаСервере();	
	
	
КонецПроцедуры

&НаСервере
Процедура ТолькоВыбранныеНаСервере()
	
		
	//УсловноеОформление.Элементы.Очистить();

	// 
	мСписокЗначений = новый СписокЗначений;
	мСписокЗначений.Добавить(1);
	мСписокЗначений.Добавить(2);
	МассивОформляемыхПолей = новый Массив;
	МассивОформляемыхПолей.Добавить("ДеревоМетаданных");
	МассивОформляемыхПолей.Добавить("ДеревоМетаданныхВыгружать");
	МассивОформляемыхПолей.Добавить("ДеревоМетаданныхПолноеИмяМетаданных");
	МассивОформляемыхПолей.Добавить("ДеревоМетаданныхВыгружатьПриНеобходимости");
	УстановитьУсловноеОформлениеДляЭлемента("Скрыть невыбранные строки",МассивОформляемыхПолей,"Объект.ДеревоМетаданных.Выгружать",мСписокЗначений,новый Структура("Параметр,Значение","Видимость", Ложь),ВидСравненияКомпоновкиДанных.НеВСписке);
	
	Элементы.ДеревоМетаданных_ТолькоВыбранные.Пометка = НЕ Элементы.ДеревоМетаданных_ТолькоВыбранные.Пометка;
	УстановитьИспользованиеЭлементаОформления("Скрыть невыбранные строки",Элементы.ДеревоМетаданных_ТолькоВыбранные.Пометка);
	
	
КонецПроцедуры

&НаСервере
Процедура УстановитьИспользованиеЭлементаОформления(ПредставлениеОформления,Использование=Истина)
	
	Для каждого стр из УсловноеОформление.Элементы Цикл
		Если стр.Представление=ПредставлениеОформления Тогда
			стр.Использование = Использование;
			Возврат;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформлениеДляЭлемента(ПредставлениеОформления,ОформляемыеПоля,ИмяЭлементаОтбора,ПравоеЗначениеОтбора,ТипОформления,ВидСравнения=Неопределено)
	
	Для каждого стр из УсловноеОформление.Элементы Цикл
		Если стр.Представление=ПредставлениеОформления Тогда
			Возврат;
		КонецЕсли;
	КонецЦикла;
	
	
	Элемент = УсловноеОформление.Элементы.Добавить();
	Элемент.Представление = ПредставлениеОформления;
	
	Если ТипЗнч(ОформляемыеПоля)=Тип("Строка") Тогда
		ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
		ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(ОформляемыеПоля);
	ИначеЕсли ТипЗнч(ОформляемыеПоля)=Тип("Массив") Тогда
		Для каждого ИмяПоля из ОформляемыеПоля Цикл
			ПолеЭлемента = Элемент.Поля.Элементы.Добавить();
			ПолеЭлемента.Поле = Новый ПолеКомпоновкиДанных(ИмяПоля); 			
		КонецЦикла;
	КонецЕсли;

	ОтборЭлемента = Элемент.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ОтборЭлемента.ЛевоеЗначение = Новый ПолеКомпоновкиДанных(ИмяЭлементаОтбора);
	Если ВидСравнения=Неопределено Тогда
		ОтборЭлемента.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	Иначе
		ОтборЭлемента.ВидСравнения = ВидСравнения;
	КонецЕсли;
	ОтборЭлемента.ПравоеЗначение = ПравоеЗначениеОтбора;

	Если ТипЗнч(ТипОформления)=Тип("Массив") Тогда
		Для каждого стр из ТипОформления Цикл
			Элемент.Оформление.УстановитьЗначениеПараметра(стр.Параметр,стр.Значение);
		КонецЦикла;
	ИначеЕсли ТипЗнч(ТипОформления)=Тип("Структура") Тогда
		Элемент.Оформление.УстановитьЗначениеПараметра(ТипОформления.Параметр,ТипОформления.Значение);
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Процедура СброситьВсе(Команда)
	
	СброситьНастройкиДерева(Объект.ДеревоМетаданных);
	
КонецПроцедуры

&НаКлиенте
Процедура СброситьНастройкиДерева(УзелДерева)
	
	ЛистьяДерева = УзелДерева.ПолучитьЭлементы();
	
	Для каждого Лист из ЛистьяДерева Цикл
		Лист.Выгружать = Ложь;
		Лист.ИспользоватьОтбор = Ложь;
		Лист.НастройкиКомпоновщика = Новый ОтборКомпоновкиДанных;
		СброситьНастройкиДерева(Лист);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте

#КонецОбласти


#Область ПроставимПодчиненныеРегистры

&НаКлиенте
Процедура ПроставитьОтборыПоПодчиненнымРегистраторам(Команда)
	
	мПараметры = новый Структура("Документ_ПолноеИмяМетаданных");
	
	// 1. Определим текущий документ
	ТекущиеДанные = Элементы.ДеревоМетаданных.ТекущиеДанные;
	
	Если НЕ ТекущиеДанные=Неопределено Тогда
		
		Родитель = ТекущиеДанные.ПолучитьРодителя();
		
		Если Родитель=Неопределено 
			ИЛИ НЕ Родитель.ПолноеИмяМетаданных="Документы" Тогда
			Сообщить("Выберите в дереве документ регистратор прежде!");
			Возврат;
		КонецЕсли;
		
		мПараметры.Документ_ПолноеИмяМетаданных = ТекущиеДанные.ПолноеИмяМетаданных;
	
	Иначе
		
		Сообщить("Выберите в дереве документ регистратор прежде!");
		Возврат;
		
	КонецЕсли;
	
	
	Форма = ПолучитьФорму("ВнешняяОбработка.СериализаторMXL.Форма.ФормаУстановкиПодчиненныхРегистраторовПоДереву",мПараметры);
	Форма.Открыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия="ВыборВыгрузкиРегистровПоРегистратору" Тогда
		
		Если ТипЗнч(Параметр)=Тип("Структура") 
			И Параметр.Свойство("МассивВыбранныхДанных") Тогда
			
			// составим соотвествие дерева
			СоответсвиеПолногоИмениЭлементамДерева = новый Соответствие;
			СформироватьСоответствиеПолногоИмениЭлементамДерева(Объект.ДеревоМетаданных,СоответсвиеПолногоИмениЭлементамДерева);
			
			УзелДокумента = СоответсвиеПолногоИмениЭлементамДерева.Получить("Документы."+Параметр.Документ_ПолноеИмяМетаданных);
			
			Если УзелДокумента=Неопределено Тогда
				Возврат;
			КонецЕсли;
		
			// 1. Получим результаты отбора
			МассивСсылок = новый Массив;
			МассивСсылок = ПолучитьРезультатСсылкамиОтбораНаСервере(УзелДокумента.НастройкиКомпоновщика,Параметр.Документ_ПолноеИмяМетаданных,"Документ");
			
			
			// 2. Пройдем по списку регистров и проставим
			// очищаем все что выбрано ранее
			МассивВыбранныхДанных = Параметр.МассивВыбранныхДанных;
			
			
			Для каждого стр из МассивВыбранныхДанных Цикл
				УзелДерева = СоответсвиеПолногоИмениЭлементамДерева.Получить(стр.ИмяВидаРегистра+"."+стр.ПолноеИмяМетаданных);
				Если УзелДерева=Неопределено Тогда 
					//ИЛИ НЕ УзелДерева.Выгружать Тогда // Виссаров [29.05.2017] ++
					Продолжить;
				КонецЕсли;
				
				// проставим флаг у родителя
				УзелДерева.ПолучитьРодителя().Выгружать=2;
				
				// формируем отбор
				УзелДерева.ИспользоватьОтбор = стр.Выгружать;
				УзелДерева.Выгружать = 1;
				УзелДерева.НастройкиКомпоновщика = СформироватьОтборНаСервере(УзелДерева.НастройкиКомпоновщика,"Регистратор",МассивСсылок,стр.Выгружать);
				
			КонецЦикла;
			
			// добавим еще корень дерева
			Если Параметр.МассивВыбранныхДанных.Количество()>0 Тогда
				Корень = Объект.ДеревоМетаданных.ПолучитьЭлементы();
				Для каждого стр из Корень Цикл
					стр.Выгружать=2;
				КонецЦикла;
			КонецЕсли;
			
			
		КонецЕсли;
		
	ИначеЕсли ИмяСобытия="ВыборВыгрузкиПоСтруктуреПодчиненности" Тогда
		
		Если ТипЗнч(Параметр)=Тип("Структура") 
			И Параметр.Свойство("МассивВыбранныхДанных") Тогда
			
			// составим соотвествие дерева
			СоответсвиеПолногоИмениЭлементамДерева = новый Соответствие;
			СформироватьСоответствиеПолногоИмениЭлементамДерева(Объект.ДеревоМетаданных,СоответсвиеПолногоИмениЭлементамДерева);
			
			// установим отборы в метаданных
			Для каждого стр из Параметр.МассивВыбранныхДанных Цикл
				
				Ключ = "Документы."+стр.ПолноеИмяМетаданных;
				
				УзелДерева = СоответсвиеПолногоИмениЭлементамДерева.Получить(Ключ);
				
				Если УзелДерева=Неопределено Тогда
					Продолжить;
				КонецЕсли;
				
				МассивСсылок = новый Массив;
				МассивСсылок.Добавить(стр.Ссылка);
				
				// проставим флаг у родителя
				УзелДерева.ПолучитьРодителя().Выгружать=2;
				
				// формируем отбор
				УзелДерева.ИспользоватьОтбор = Истина;
				УзелДерева.Выгружать = 1;
				УзелДерева.НастройкиКомпоновщика = СформироватьОтборНаСервере(УзелДерева.НастройкиКомпоновщика,"Ссылка",МассивСсылок,Истина);
				
				
				
			КонецЦикла;
			
			// добавим еще корень дерева
			Если Параметр.МассивВыбранныхДанных.Количество()>0 Тогда
				Корень = Объект.ДеревоМетаданных.ПолучитьЭлементы();
				Для каждого стр из Корень Цикл
					стр.Выгружать=2;
				КонецЦикла;
			КонецЕсли;
			
		
		КонецЕсли;
		
	ИначеЕсли ИмяСобытия="ВыборВыгрузкиПоСтруктуреСсылокОбъекта" Тогда
		
		Если ТипЗнч(Параметр)=Тип("Структура") 
			И Параметр.Свойство("МассивВыбранныхДанных") Тогда
			
			// составим соотвествие дерева
			СоответсвиеПолногоИмениЭлементамДерева = новый Соответствие;
			СформироватьСоответствиеПолногоИмениЭлементамДерева(Объект.ДеревоМетаданных,СоответсвиеПолногоИмениЭлементамДерева);
			
			// установим отборы в метаданных
			Для каждого стр из Параметр.МассивВыбранныхДанных Цикл
				
				Если ПолучитьТипМетаданныхСтрокой(стр.Ссылка)="Документы" Тогда
					
					Ключ = "Документы."+стр.ПолноеИмяМетаданных;
					
				ИначеЕсли ПолучитьТипМетаданныхСтрокой(стр.Ссылка)="Справочники" Тогда
					
					Ключ = "Справочники."+стр.ПолноеИмяМетаданных;
					
				Иначе
					Продолжить;
				КонецЕсли;
				
				УзелДерева = СоответсвиеПолногоИмениЭлементамДерева.Получить(Ключ);
				
				Если УзелДерева=Неопределено Тогда
					Продолжить;
				КонецЕсли;
				
				МассивСсылок = новый Массив;
				МассивСсылок.Добавить(стр.Ссылка);
				
				// проставим флаг у родителя
				УзелДерева.ПолучитьРодителя().Выгружать=2;
				
				// формируем отбор
				УзелДерева.ИспользоватьОтбор = Истина;
				УзелДерева.Выгружать = 1;
				УзелДерева.НастройкиКомпоновщика = СформироватьОтборНаСервере(УзелДерева.НастройкиКомпоновщика,"Ссылка",МассивСсылок,Истина);
				
			КонецЦикла;
			
			// добавим еще корень дерева
			Если Параметр.МассивВыбранныхДанных.Количество()>0 Тогда
				Корень = Объект.ДеревоМетаданных.ПолучитьЭлементы();
				Для каждого стр из Корень Цикл
					стр.Выгружать=2;
				КонецЦикла;
			КонецЕсли;
			
		
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьТипМетаданныхСтрокой(Знач Ссылка)
	РезультатСтрокой = "Неопределено";
	
	Если Метаданные.Документы.Содержит(Ссылка.Метаданные()) Тогда
		РезультатСтрокой = "Документы";
	ИначеЕсли Метаданные.Справочники.Содержит(Ссылка.Метаданные()) Тогда
		РезультатСтрокой = "Справочники";
	КонецЕсли;
	
	Возврат РезультатСтрокой;
КонецФункции

&НаСервере
Функция ПолучитьРезультатСсылкамиОтбораНаСервере(ОтборКомпоновщика,Знач ИмяМетаданных,Знач ИмяТипаМетаданных)
	
	МассивСсылок = новый Массив;
	СКД = новый СхемаКомпоновкиДанных;
	
	// определим источник данных для схемы 
	Источник = СКД.ИсточникиДанных.Добавить();
	Источник.Имя = "Local";
	Источник.СтрокаСоединения = "";
	Источник.ТипИсточникаДанных = "Local"; 	
	
	НаборДанных = СКД.НаборыДанных.Добавить(Тип("НаборДанныхЗапросСхемыКомпоновкиДанных"));
	НаборДанных.Имя = "Ссылки";
	НаборДанных.ИсточникДанных = "Local";
	НаборДанных.АвтоЗаполнениеДоступныхПолей = Истина;	

	ТекстЗапроса = "ВЫБРАТЬ
	|	Т.Ссылка КАК Ссылка
	|ИЗ
	|	"+ИмяТипаМетаданных+"."+ИмяМетаданных+" КАК Т";
	СКД.НаборыДанных.Ссылки.Запрос = ТекстЗапроса;
	
	// получим настройки для схемы 
    НастройкиСКД = СКД.НастройкиПоУмолчанию;
	Для каждого стр из ОтборКомпоновщика.Элементы Цикл
		стр_н = НастройкиСКД.Отбор.Элементы.Добавить(ТипЗнч(стр));
		ЗаполнитьЗначенияСвойств(стр_н,стр);		
	КонецЦикла;
	
	//Добавим выбранные поля к нашему отчету (Эти поля будут наследоватся автополем в группировках ниже)
    ВыбранноеПолеСсылка           = НастройкиСКД.Выбор.Элементы.Добавить(Тип("ВыбранноеПолеКомпоновкиДанных"));
    ВыбранноеПолеСсылка.Поле      = Новый ПолеКомпоновкиДанных("Ссылка");
    ВыбранноеПолеСсылка.Заголовок = "Ссылка";    	
	
	
	ДетальноеПолеГруппировки = НастройкиСКД.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
	ДетальноеПолеГруппировки.Выбор.Элементы.Добавить(Тип("АвтоВыбранноеПолеКомпоновкиДанных"));
    ДетальноеПолеГруппировки.Использование = Истина;
	
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	МакетКомпоновки   = КомпоновщикМакета.Выполнить(СКД, НастройкиСКД,,,Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
	
	ПроцессорКомпоновкиДанных = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновкиДанных.Инициализировать(МакетКомпоновки);
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
	ТаблицаЗначений = ПроцессорВывода.Вывести(ПроцессорКомпоновкиДанных);
	
	Для каждого стр из ТаблицаЗначений Цикл
		МассивСсылок.Добавить(стр.Ссылка);
	КонецЦикла;	
	
	Возврат МассивСсылок;
	
КонецФункции


&НаКлиенте
Функция  СформироватьОтборНаСервере(НастройкиКомпоновщика,ИмяПоля,МассивСсылок,Использование)
	НовыйОтбор = Новый ОтборКомпоновкиДанных;
	
	Если Использование=Истина Тогда
		
		ЭлементОтбора = НовыйОтбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		
		// если есть отбор вариант в списке
		Если НастройкиКомпоновщика.Элементы.Количество()=1 И 
			НастройкиКомпоновщика.Элементы[0].ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке Тогда
			мСоотв = новый Соответствие;
			Для каждого стр из МассивСсылок Цикл
				мСоотв.Вставить(стр,стр);
			КонецЦикла;
			Для каждого стр из НастройкиКомпоновщика.Элементы[0].ПравоеЗначение Цикл
				Если мСоотв.Получить(стр.Значение)=Неопределено Тогда
					МассивСсылок.Добавить(стр.Значение);	
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
		
		мСписокЗначений = новый СписокЗначений;
		мСписокЗначений.ЗагрузитьЗначения(МассивСсылок);
		
		ЭлементОтбора.ПравоеЗначение = мСписокЗначений;
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
		ЭлементОтбора.Использование = Истина;
		
		ЛевоеЗначение = новый ПолеКомпоновкиДанных(ИмяПоля);
		ЭлементОтбора.ЛевоеЗначение = ЛевоеЗначение;
	КонецЕсли;
	
	Возврат НовыйОтбор;
КонецФункции

&НаКлиенте 
Процедура СформироватьСоответствиеПолногоИмениЭлементамДерева(ДеревоМетаданных,СоответсвиеПолногоИмениЭлементамДерева,Знач Уровень=0 )
	
	УзлыДерева = ДеревоМетаданных.ПолучитьЭлементы();
	
	
	Для каждого Узел из УзлыДерева Цикл
		
		Если Уровень > 0 Тогда
			Родитель = Узел.ПолучитьРодителя();
			ПолноеИмяМетаданных = СтрЗаменить(Родитель.ПолноеИмяМетаданных,"Регистры","Регистр");
			СоответсвиеПолногоИмениЭлементамДерева.Вставить(ПолноеИмяМетаданных+"."+Узел.ПолноеИмяМетаданных,Узел);
		КонецЕсли;
		
		Уровень = Уровень+1;
		СформироватьСоответствиеПолногоИмениЭлементамДерева(Узел,СоответсвиеПолногоИмениЭлементамДерева,Уровень);	
		
	КонецЦикла; 	
	
КонецПроцедуры

#КонецОбласти



#Область СтруктураПодчиенности

&НаКлиенте
Функция ПроверитьОтборПустой(Узел)
	
	Если Узел.НастройкиКомпоновщика.Элементы.Количество()=0 Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;	
	
КонецФункции

&НаКлиенте
Процедура ПодобратьДанныеПоСтруктуреПодчиненности(Команда)
	
	мПараметры = новый Структура("ПолноеИмяМетаданных,ИмяТипаМетаданных,ДокументСсылка");
	
	// 1. Определим текущий документ
	ТекущиеДанные = Элементы.ДеревоМетаданных.ТекущиеДанные;
	
	Если НЕ ТекущиеДанные=Неопределено Тогда
		
		Родитель = ТекущиеДанные.ПолучитьРодителя();
		
		Если Родитель=Неопределено
			ИЛИ Родитель.ПолноеИмяМетаданных="Документы" Тогда
			мПараметры.ИмяТипаМетаданных = "Документ";
			мПараметры.ПолноеИмяМетаданных = ТекущиеДанные.ПолноеИмяМетаданных;
		ИначеЕсли Родитель=Неопределено 
			ИЛИ Родитель.ПолноеИмяМетаданных="Справочники" Тогда
			мПараметры.ИмяТипаМетаданных = "Справочник";
			мПараметры.ПолноеИмяМетаданных = ТекущиеДанные.ПолноеИмяМетаданных;
		КонецЕсли;
		
		
		// определим данные, первую ссылку
		Если ЗначениеЗаполнено(мПараметры.ПолноеИмяМетаданных) Тогда
			Если НЕ ПроверитьОтборПустой(ТекущиеДанные)=Истина Тогда
				МассивСсылок = новый Массив;
				МассивСсылок = ПолучитьРезультатСсылкамиОтбораНаСервере(ТекущиеДанные.НастройкиКомпоновщика,мПараметры.ПолноеИмяМетаданных,мПараметры.ИмяТипаМетаданных);
				Если МассивСсылок.Количество()>0 тогда
					мПараметры.ДокументСсылка = МассивСсылок[0];	
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;		
		
	КонецЕсли;    	
	
	Форма = ПолучитьФорму("ВнешняяОбработка.СериализаторMXL.Форма.ФормаСтруктурыПодчиненности",мПараметры);
	Форма.Открыть();

КонецПроцедуры


#КонецОбласти

#Область ПроставитьОтборПодчиненныхСсылок

&НаКлиенте
Процедура ПроставитьОтборПодчиненныхСсылок(Команда)
	мПараметры = новый Структура("ПолноеИмяМетаданных,ИмяТипаМетаданных,ОбъектСсылка");
	
	// 1. Определим текущий объект (справочник или документ)
	ТекущиеДанные = Элементы.ДеревоМетаданных.ТекущиеДанные;
	
	Если НЕ ТекущиеДанные=Неопределено Тогда
		
		Родитель = ТекущиеДанные.ПолучитьРодителя();
		
		Если Родитель=Неопределено Тогда
		ИначеЕсли Родитель.ПолноеИмяМетаданных="Документы" Тогда
			мПараметры.ИмяТипаМетаданных = "Документ";
			мПараметры.ПолноеИмяМетаданных = ТекущиеДанные.ПолноеИмяМетаданных;
		ИначеЕсли Родитель.ПолноеИмяМетаданных="Справочники" Тогда
			мПараметры.ИмяТипаМетаданных = "Справочник";
			мПараметры.ПолноеИмяМетаданных = ТекущиеДанные.ПолноеИмяМетаданных;
		КонецЕсли;
		
		
		// определим данные, первую ссылку
		Если ЗначениеЗаполнено(мПараметры.ПолноеИмяМетаданных) Тогда
			Если НЕ ПроверитьОтборПустой(ТекущиеДанные)=Истина Тогда
				МассивСсылок = новый Массив;
				МассивСсылок = ПолучитьРезультатСсылкамиОтбораНаСервере(ТекущиеДанные.НастройкиКомпоновщика,мПараметры.ПолноеИмяМетаданных,мПараметры.ИмяТипаМетаданных);
				Если МассивСсылок.Количество()>0 тогда
					мПараметры.ОбъектСсылка = МассивСсылок[0];	
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;		
		
	КонецЕсли;    	
	
	Форма = ПолучитьФорму("ВнешняяОбработка.СериализаторMXL.Форма.ФормаСтруктурыСсылокОбъекта",мПараметры);
	Форма.Открыть();

КонецПроцедуры

#КонецОбласти

#Область Команды

&НаКлиенте
Процедура ЗагрузитьМакетИзФайла(Команда)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие); 
	Диалог.Заголовок = "Выберите файл"; 
	Диалог.ПолноеИмяФайла = ""; 
	Фильтр = "Табличный документ (*.mxl)|*.mxl|Все файлы (*.*)|*.*";
	Диалог.Фильтр = Фильтр; 
	Диалог.МножественныйВыбор = Ложь; 
	ВыборФайлаЗагрузкиФайлаМакета = новый ОписаниеОповещения("ВыборФайлаЗагрузкиФайлаМакета",ЭтотОбъект);
	Диалог.Показать(ВыборФайлаЗагрузкиФайлаМакета);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборФайлаЗагрузкиФайлаМакета(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	 Если ВыбранныеФайлы <> Неопределено И ВыбранныеФайлы.Количество() > 0 Тогда
		ПутьКФайлу = ВыбранныеФайлы[0]; 
		// загрузим макет
		ДвоичныеДанные = новый ДвоичныеДанные(ПутьКФайлу);
		ФайлСтрокой = Base64Строка(ДвоичныеДанные);
		ЗагрузитьМакетНаСервере(ФайлСтрокой);
	КонецЕсли; 
	
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьМакетНаСервере(ФайлСтрокой)
	
	ИмяВременногоФАйла = ПолучитьИмяВременногоФайла("mxl");
	ДвоичныеДанные = Base64Значение(ФайлСтрокой);
	ДвоичныеДанные.Записать(ИмяВременногоФАйла);
	Макет.Прочитать(ИмяВременногоФАйла);
	
	Попытка
		УдалитьФайлы(ИмяВременногоФАйла);
	Исключение
		Сообщить("При удалении временного файла ошибка:"+Символы.ПС+ОписаниеОшибки());
	КонецПопытки;
	
Конецпроцедуры


&НаСервере
Процедура ЗагрузитьДанныеМакетаВБазуНаСервере()
	Объект().ПроверитьЗагрузкуМакета(Макет,Истина);
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьДанныеМакетаВБазу(Команда)
	ЗагрузитьДанныеМакетаВБазуНаСервере();
КонецПроцедуры


#КонецОбласти
