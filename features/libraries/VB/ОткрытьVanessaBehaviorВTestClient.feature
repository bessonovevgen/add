﻿# language: ru

@IgnoreOnCIMainBuild

@ExportScenarios


Функционал: Загрузить фичу в vanessa-behavior
	Как Разработчик
	Я Хочу чтобы чтобы у меня был сценарий для открытия Vanessa-Behavior в TestClient
	Чтобы я мог его переиспользовать
 

Сценарий: Я открываю VanessaBehavior в режиме TestClient

		Дано в Константе "ПутьКVanessaBehavior" указан существующий файл
		Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий с закрытием всех окон кроме "* Vanessa behavior"
		Когда В панели разделов я выбираю "Основная"
		И В панели функций я выбираю "Открыть vanessa behavior"
		И я фиксирую текущую форму
		Тогда открылось окно "* Vanessa behavior"
		И В открытой форме я перехожу к закладке с заголовком "Сервис"
		И я устанавливаю флаг "Проверка работы Vanessa-Behavior в режиме test client"
		И я нажимаю кнопку очистить у поля "Список исключаемых тэгов"
		И я нажимаю кнопку очистить у поля "Тэги для запуска"
		И В открытой форме я перехожу к закладке с заголовком "Служебная"
		И В поле с именем "КаталогИнструментовСлужебный" я указываю значение реквизита объекта обработки "КаталогИнструментов"
		И В поле с именем "ДиапазонПортовTestclient" я указываю значение реквизита объекта обработки "ДиапазонПортовTestclient"
		И В открытой форме я перехожу к закладке с заголовком "Библиотеки"
		И В открытой форме я нажимаю на кнопку с именем "КаталогиБиблиотекОчистить"
		И В открытой форме я перехожу к закладке с заголовком "Служебная"
		И В поле с именем "КаталогИнструментовСлужебный" я указываю значение реквизита объекта обработки "КаталогИнструментов"
		И  я снимаю флаг "Сценарии загружены"
		И  я снимаю флаг "Сценарии выполнены"
		И     я перехожу к закладке "Сервис"
		И     из выпадающего списка "Язык генератора Gherkin" я выбираю "Русский"
		И я отменяю фиксирование формы


Сценарий: Я открываю VanessaBehavior в режиме TestClient со стандартной библиотекой не подключая TestClient

		Дано в Константе "ПутьКVanessaBehavior" указан существующий файл
		Когда В панели разделов я выбираю "Основная"
		И В панели функций я выбираю "Открыть vanessa behavior"
		Тогда открылось окно "* Vanessa behavior"
		И я фиксирую текущую форму
		И В открытой форме я перехожу к закладке с заголовком "Сервис"
		И я устанавливаю флаг "Проверка работы Vanessa-Behavior в режиме test client"
		И я нажимаю кнопку очистить у поля "Список исключаемых тэгов"
		И я нажимаю кнопку очистить у поля "Тэги для запуска"
		И В открытой форме я перехожу к закладке с заголовком "Служебная"
		И В поле с именем "КаталогИнструментовСлужебный" я указываю значение реквизита объекта обработки "КаталогИнструментов"
		И В поле с именем "ДиапазонПортовTestclient" я указываю значение реквизита объекта обработки "ДиапазонПортовTestclient"
		И В поле "Таймаут запуска TestClient" я ввожу текст "60"
		И В открытой форме я перехожу к закладке с заголовком "Библиотеки"
		И В открытой форме я нажимаю на кнопку с именем "КаталогиБиблиотекОчистить"
		И В открытой форме я нажимаю на кнопку с именем "КаталогиБиблиотекДобавить"
		И я добавляю в библиотеки строку с стандартной библиотекой "libraries"
		И В открытой форме я перехожу к закладке с заголовком "Служебная"
		И В поле с именем "КаталогИнструментовСлужебный" я указываю значение реквизита объекта обработки "КаталогИнструментов"
		И  я снимаю флаг "Сценарии загружены"
		И  я снимаю флаг "Сценарии выполнены"
		И     я перехожу к закладке "Сервис"
		И     из выпадающего списка "Язык генератора Gherkin" я выбираю "Русский"
		И я отменяю фиксирование формы

		
		
		
Сценарий: Я открываю VanessaBehavior в режиме TestClient со стандартной библиотекой

		Дано в Константе "ПутьКVanessaBehavior" указан существующий файл
		Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий с закрытием всех окон кроме "* Vanessa behavior"
		Когда В панели разделов я выбираю "Основная"
		И В панели функций я выбираю "Открыть vanessa behavior"
		Тогда открылось окно "* Vanessa behavior"
		И я фиксирую текущую форму
		И В открытой форме я перехожу к закладке с заголовком "Сервис"
		И я устанавливаю флаг "Проверка работы Vanessa-Behavior в режиме test client"
		И я нажимаю кнопку очистить у поля "Список исключаемых тэгов"
		И я нажимаю кнопку очистить у поля "Тэги для запуска"
		И В открытой форме я перехожу к закладке с заголовком "Служебная"
		И В поле с именем "КаталогИнструментовСлужебный" я указываю значение реквизита объекта обработки "КаталогИнструментов"
		И В поле с именем "ДиапазонПортовTestclient" я указываю значение реквизита объекта обработки "ДиапазонПортовTestclient"
		И В поле "Таймаут запуска TestClient" я ввожу текст "60"
		И В открытой форме я перехожу к закладке с заголовком "Библиотеки"
		И В открытой форме я нажимаю на кнопку с именем "КаталогиБиблиотекОчистить"
		И В открытой форме я нажимаю на кнопку с именем "КаталогиБиблиотекДобавить"
		И я добавляю в библиотеки строку с стандартной библиотекой "libraries"
		И В открытой форме я перехожу к закладке с заголовком "Служебная"
		И В поле с именем "КаталогИнструментовСлужебный" я указываю значение реквизита объекта обработки "КаталогИнструментов"
		И  я снимаю флаг "Сценарии загружены"
		И  я снимаю флаг "Сценарии выполнены"
		И     я перехожу к закладке "Сервис"
		И     из выпадающего списка "Язык генератора Gherkin" я выбираю "Русский"
		И я отменяю фиксирование формы

		
Сценарий: Я открываю VanessaBehavior в режиме TestClient со стандартной библиотекой для запуска в раннере

		Дано в Константе "ПутьКVanessaBehavior" указан существующий файл
		Когда В панели разделов я выбираю "Основная"
		И В панели функций я выбираю "Открыть vanessa behavior"
		Тогда открылось окно "* Vanessa behavior"
		И я фиксирую текущую форму
		И В открытой форме я перехожу к закладке с заголовком "Сервис"
		И я устанавливаю флаг "Проверка работы Vanessa-Behavior в режиме test client"
		И я нажимаю кнопку очистить у поля "Список исключаемых тэгов"
		И я нажимаю кнопку очистить у поля "Тэги для запуска"
		И В открытой форме я перехожу к закладке с заголовком "Служебная"
		И В поле с именем "КаталогИнструментовСлужебный" я указываю значение реквизита объекта обработки "КаталогИнструментов"
		И В поле с именем "ДиапазонПортовTestclient" я указываю значение реквизита объекта обработки "ДиапазонПортовTestclient"
		И В поле "Таймаут запуска TestClient" я ввожу текст "60"
		И В поле с именем "КаталогИнструментовСлужебный" я указываю значение реквизита объекта обработки "КаталогИнструментов"
		И В открытой форме я перехожу к закладке с заголовком "Служебная"
		И В поле с именем "КаталогИнструментовСлужебный" я указываю значение реквизита объекта обработки "КаталогИнструментов"
		И я снимаю флаг "Режим самотестирования"
		#И я нажимаю на кнопку "Сохранить настройки клиент"
		И В открытой форме я перехожу к закладке с заголовком "Библиотеки"
		И В открытой форме я нажимаю на кнопку с именем "КаталогиБиблиотекОчистить"
		И В открытой форме я нажимаю на кнопку с именем "КаталогиБиблиотекДобавить"
		И я добавляю в библиотеки строку с стандартной библиотекой "libraries"
		И  я снимаю флаг "Сценарии загружены"
		И  я снимаю флаг "Сценарии выполнены"
		И     я перехожу к закладке "Сервис"
		И     из выпадающего списка "Язык генератора Gherkin" я выбираю "Русский"
		И я отменяю фиксирование формы

				