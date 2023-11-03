"
An OTelJavaLogFileExtractorTest is a test class for testing the behavior of OTelJavaLogFileExtractor
"
Class {
	#name : #OTelJavaLogFileExtractorTest,
	#superclass : #TestCase,
	#category : #'Famix-OpenTelemetry-Importer-Tests'
}

{ #category : #test }
OTelJavaLogFileExtractorTest >> testParseLog [

	| spanString span |
	spanString := '[otel.javaagent 2023-10-16 09:33:10:923 +0200] [RMI TCP Connection(5)-10.31.101.22] INFO io.opentelemetry.exporter.logging.LoggingSpanExporter - ''tier-list-span'' : 5a6cac34502cb8bd01dc52f1e6e6ea50 2a8e9b2cddc5a6d4 INTERNAL [tracer: fr.drit.usecases-1.0:] AttributesMap{data={thread.id=35, drit.stackcall=||>|fr.magnus.uctierscomptable.usecase.UcTiersComptableImpl.fournirListeTiersComptablesIHM(UcTiersComptableImpl.java:97)|<||, drit.method="public static void fr.magnus.reftechnique.service.transaction.Transaction.demarrer(fr.magnus.reftechnique.service.transaction.TransactionDemandeurIntf) throws fr.magnus.reftechnique.service.transaction.TransactionException", drit.order=2, thread.name=RMI TCP Connection(5)-10.31.101.22, drit.parentId="7ce367b356a6b113", drit.timestamp=1697441590923}, capacity=128, totalAddedValues=7}'.

	span := OTelJavaLogFileExtractor new parseLog: spanString.

	self assert: (span at: #name) = 'tier-list-span'.
	self assert: (span at: #id) = '2a8e9b2cddc5a6d4'.
	self assert: (span at: #timestamp) = '1697441590923'.
	self assert: (span at: #parentId) = '7ce367b356a6b113'.
	self assert: (span at: #traceId) = '5a6cac34502cb8bd01dc52f1e6e6ea50'.
	self assert: ((span at: #tags) at: 'drit.method')
		=
		'public static void fr.magnus.reftechnique.service.transaction.Transaction.demarrer(fr.magnus.reftechnique.service.transaction.TransactionDemandeurIntf) throws fr.magnus.reftechnique.service.transaction.TransactionException'.
	self assert: ((span at: #tags) at: 'drit.order') = '2'.
	self assert: ((span at: #tags) at: 'drit.stackcall') = 'fr.magnus.uctierscomptable.usecase.UcTiersComptableImpl.fournirListeTiersComptablesIHM(UcTiersComptableImpl.java:97)'
]

{ #category : #test }
OTelJavaLogFileExtractorTest >> testParseLogStackcallInit [

	| spanString span |
	spanString := '[otel.javaagent 2023-10-16 09:33:10:946 +0200] [RMI TCP Connection(5)-10.31.101.22] INFO io.opentelemetry.exporter.logging.LoggingSpanExporter - ''tier-list-span'' : 5a6cac34502cb8bd01dc52f1e6e6ea50 e94697ab6cec7047 INTERNAL [tracer: fr.drit.usecases-1.0:] AttributesMap{data={thread.id=35, drit.stackcall=||>|fr.magnus.reftechnique.transverse.recherche.RechercheCritere.<init>(RechercheCritere.java:29)|<||, drit.method="public void fr.magnus.reftechnique.transverse.recherche.RechercheCritere.setValeur(java.lang.Object)", drit.order=19, thread.name=RMI TCP Connection(5)-10.31.101.22, drit.parentId="e7002b5cf1509771", drit.timestamp=1697441590946}, capacity=128, totalAddedValues=7}'.

	span := OTelJavaLogFileExtractor new parseLog: spanString.

	self assert: (span at: #name) = 'tier-list-span'.
	self assert: (span at: #id) = 'e94697ab6cec7047'.
	self assert: (span at: #timestamp) = '1697441590946'.
	self assert: (span at: #parentId) = 'e7002b5cf1509771'.
	self assert: (span at: #traceId) = '5a6cac34502cb8bd01dc52f1e6e6ea50'.
	self assert: ((span at: #tags) at: 'drit.method')
		=
		'public void fr.magnus.reftechnique.transverse.recherche.RechercheCritere.setValeur(java.lang.Object)'.
	self assert: ((span at: #tags) at: 'drit.order') = '19'.
	self assert: ((span at: #tags) at: 'drit.stackcall') = 'fr.magnus.reftechnique.transverse.recherche.RechercheCritere.<init>(RechercheCritere.java:29)'
]
