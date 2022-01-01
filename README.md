# nuova_aurora

Applicazione per ordini Pizzeria Nuova Aurora.
Vuole essere uno spunto per provare l'accesso a Firebase da Flutter
L'uso del plug provider introduce lo studio dello 'State management'

## Primo step
L'applicazione deve accedere al database Firestore per visualizzare il menu
delle pizze, bevande ed altro

## Secondo step
TODO - Abilitare anche agli ordini ?

## Step
Notifiche

## Terzo step - Versione per manager
Gestione autenticazione

Versione NON pubblica !
TODO - Avere accesso alla modifica dei menu e prezzi
Vedere la modalità di autenticazione di Firestore

Versione NON pubblica !
TODO - Pagina di manutenzione del DB - cancellazione ordini vecchi


# Accesso a Firebase e al DB FireStore

## Articolo: 

Plugin:

https://pub.dev/packages/cloud_firestore
Da: 
https://firebase.flutter.dev/docs/firestore/overview/
https://firebase.flutter.dev/docs/firestore/usage
One-time read


https://pub.dev/packages/firebase_database

## Libro:
Flutter Apprentice by Michael Katz, Kevin David Moore, Vincent Ngo, Vincenzo Guzzi

Per accedere è necessario creare un config file per Android (ed eventualmente uno per iOS): il file
contiene tutte le API keys per il progetto.
La console di Google permette di generare tale file aggiungendo un tipo di app al
progetto preesistente, aggiungendo il tipo 'Android'.

Nome pacchetto: com.stemmo.nuova_aurora
Nick name: 'Nuova Aurora'
Scaricato il file 'google-services.json'

L'applicazione usa il package 'provider' come State Manager.

