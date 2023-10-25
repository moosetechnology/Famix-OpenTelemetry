"
An OTelZipkinLoaderTest is a test class for testing the behavior of OTelZipkinLoader
"
Class {
	#name : #OTelJavaLogFileLoaderTest,
	#superclass : #TestCase,
	#category : #'Famix-OpenTelemetry-Importer-Tests'
}

{ #category : #test }
OTelJavaLogFileLoaderTest >> testLoad [

	| spanString rawtraces model |
	spanString := '[otel.javaagent 2023-10-16 09:33:10:921 +0200] [RMI TCP Connection(5)-10.31.101.22] INFO io.opentelemetry.exporter.logging.LoggingSpanExporter - ''tier-list-span'' : 5a6cac34502cb8bd01dc52f1e6e6ea50 7ce367b356a6b113 INTERNAL [tracer: fr.drit.usecases-1.0:] AttributesMap{data={thread.id=35, drit.stackcall=||>|sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)|<||, drit.method="public fr.magnus.reftechnique.transverse.tableau.TableauEntitePersistante fr.magnus.uctierscomptable.usecase.UcTiersComptableImpl.fournirListeTiersComptablesIHM(fr.magnus.uctierscomptable.transverse.TiersComptableCriteres) throws java.rmi.RemoteException,fr.magnus.reftechnique.transverse.exception.UseCaseException", drit.order=1, thread.name=RMI TCP Connection(5)-10.31.101.22, drit.parentId="0000000000000000", drit.timestamp=1697441590920}, capacity=128, totalAddedValues=7}
[otel.javaagent 2023-10-16 09:33:10:923 +0200] [RMI TCP Connection(5)-10.31.101.22] INFO io.opentelemetry.exporter.logging.LoggingSpanExporter - ''tier-list-span'' : 5a6cac34502cb8bd01dc52f1e6e6ea50 2a8e9b2cddc5a6d4 INTERNAL [tracer: fr.drit.usecases-1.0:] AttributesMap{data={thread.id=35, drit.stackcall=||>|fr.magnus.uctierscomptable.usecase.UcTiersComptableImpl.fournirListeTiersComptablesIHM(UcTiersComptableImpl.java:97)|<||, drit.method="public static void fr.magnus.reftechnique.service.transaction.Transaction.demarrer(fr.magnus.reftechnique.service.transaction.TransactionDemandeurIntf) throws fr.magnus.reftechnique.service.transaction.TransactionException", drit.order=2, thread.name=RMI TCP Connection(5)-10.31.101.22, drit.parentId="7ce367b356a6b113", drit.timestamp=1697441590923}, capacity=128, totalAddedValues=7}
[otel.javaagent 2023-10-16 09:33:10:923 +0200] [RMI TCP Connection(5)-10.31.101.22] INFO io.opentelemetry.exporter.logging.LoggingSpanExporter - ''tier-list-span'' : 5a6cac34502cb8bd01dc52f1e6e6ea50 63f209856013ac27 INTERNAL [tracer: fr.drit.usecases-1.0:] AttributesMap{data={thread.id=35, drit.stackcall=||>|fr.magnus.reftechnique.service.transaction.Transaction.demarrer(Transaction.java:64)|<||, drit.method="public static void fr.magnus.reftechnique.service.transaction.Transaction.demarrer(fr.magnus.reftechnique.service.transaction.ContexteTransactionnel) throws fr.magnus.reftechnique.service.transaction.TransactionException", drit.order=3, thread.name=RMI TCP Connection(5)-10.31.101.22, drit.parentId="2a8e9b2cddc5a6d4", drit.timestamp=1697441590923}, capacity=128, totalAddedValues=7}'.

	rawtraces := OTelJavaLogFileExtractor new parsingAllLogLines:
		             spanString readStream.
	model := OTelJavaLogFileLoader new load: rawtraces.

	self assert: model entities size equals: 5.
	self
		assert:
		(model entities detect: [ :e | e isKindOf: FamixOTelTrace ])
			isNotNil
		equals: true.
	self
		assert:
			(model entities detect: [ :e | e isKindOf: FamixOTelContext ])
				isNotNil
		equals: true.
	self
		assert:
		(model entities detect: [ :e | e isKindOf: FamixOTelSpan ]) isNotNil
		equals: true
]

{ #category : #test }
OTelJavaLogFileLoaderTest >> testLoadV2 [

	| spanString rawtraces model |
	spanString := '[otel.javaagent 2023-10-16 09:33:10:921 +0200] [RMI TCP Connection(5)-10.31.101.22] INFO io.opentelemetry.exporter.logging.LoggingSpanExporter - ''tier-list-span'' : 5a6cac34502cb8bd01dc52f1e6e6ea50 7ce367b356a6b113 INTERNAL [tracer: fr.drit.usecases-1.0:] AttributesMap{data={thread.id=35, drit.stackcall=||>|sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)|<||, drit.method="public fr.magnus.reftechnique.transverse.tableau.TableauEntitePersistante fr.magnus.uctierscomptable.usecase.UcTiersComptableImpl.fournirListeTiersComptablesIHM(fr.magnus.uctierscomptable.transverse.TiersComptableCriteres) throws java.rmi.RemoteException,fr.magnus.reftechnique.transverse.exception.UseCaseException", drit.order=1, thread.name=RMI TCP Connection(5)-10.31.101.22, drit.parentId="0000000000000000", drit.timestamp=1697441590920}, capacity=128, totalAddedValues=7}
[otel.javaagent 2023-10-16 09:33:10:923 +0200] [RMI TCP Connection(5)-10.31.101.22] INFO io.opentelemetry.exporter.logging.LoggingSpanExporter - ''tier-list-span'' : 5a6cac34502cb8bd01dc52f1e6e6ea50 2a8e9b2cddc5a6d4 INTERNAL [tracer: fr.drit.usecases-1.0:] AttributesMap{data={thread.id=35, drit.stackcall=||>|fr.magnus.uctierscomptable.usecase.UcTiersComptableImpl.fournirListeTiersComptablesIHM(UcTiersComptableImpl.java:97)|<||, drit.method="public static void fr.magnus.reftechnique.service.transaction.Transaction.demarrer(fr.magnus.reftechnique.service.transaction.TransactionDemandeurIntf) throws fr.magnus.reftechnique.service.transaction.TransactionException", drit.order=2, thread.name=RMI TCP Connection(5)-10.31.101.22, drit.parentId="7ce367b356a6b113", drit.timestamp=1697441590923}, capacity=128, totalAddedValues=7}
[otel.javaagent 2023-10-16 09:33:10:923 +0200] [RMI TCP Connection(5)-10.31.101.22] INFO io.opentelemetry.exporter.logging.LoggingSpanExporter - ''tier-list-span'' : 5a6cac34502cb8bd01dc52f1e6e6ea50 63f209856013ac27 INTERNAL [tracer: fr.drit.usecases-1.0:] AttributesMap{data={thread.id=35, drit.stackcall=||>|fr.magnus.reftechnique.service.transaction.Transaction.demarrer(Transaction.java:64)|<||, drit.method="public static void fr.magnus.reftechnique.service.transaction.Transaction.demarrer(fr.magnus.reftechnique.service.transaction.ContexteTransactionnel) throws fr.magnus.reftechnique.service.transaction.TransactionException", drit.order=3, thread.name=RMI TCP Connection(5)-10.31.101.22, drit.parentId="2a8e9b2cddc5a6d4", drit.timestamp=1697441590923}, capacity=128, totalAddedValues=7}'.

	rawtraces := OTelJavaLogFileExtractor new parsingAllLogLines:
		             spanString readStream.
	model := OTelJavaLogFileLoader new load: rawtraces.

	self assert: model entities size equals: 5.
	self
		assert:
		(model entities detect: [ :e | e isKindOf: FamixOTelTrace ])
			isNotNil
		equals: true.
	self
		assert:
			(model entities detect: [ :e | e isKindOf: FamixOTelContext ])
				isNotNil
		equals: true.
	self
		assert:
		(model entities detect: [ :e | e isKindOf: FamixOTelSpan ]) isNotNil
		equals: true
]
