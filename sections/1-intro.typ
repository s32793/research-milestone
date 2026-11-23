= Introduction

IoT and edge devices such as environmental monitoring stations, industrial
machines, vehicles, drones and gateway boards continuously produce timestamped
numeric readings: temperature, humidity, pressure, vibration, motion or
position. These devices typically have limited CPU, memory and storage, often
have no reliable network link, and run on batteries or unstable power. The data
therefore has to be stored locally and compactly until it can be analysed, and
the storage must remain consistent and recoverable after sudden interruptions
such as a power loss.

Sensor data also has a regular structure that general-purpose storage does not
exploit. Consecutive timestamps are usually separated by nearly constant
intervals, and consecutive values of a physical quantity tend to change
smoothly. Time-series databases use this property with techniques such as
delta-of-delta timestamp encoding and XOR-based compression of floating-point
values @pelkonen2015gorilla.

Existing options leave a gap for resource-constrained devices. Flat files and
CSV are simple, but they are uncompressed and inefficient to query.
Server-based time-series databases such as InfluxDB or TimescaleDB are
designed for server environments and are heavy for small devices.
General-purpose engines such as SQLite or DuckDB are not specialised for
high-frequency single-row inserts and generally do not compress sensor data.
Research systems aimed at embedded devices exist, for example EmbedDB
@, and we will compare our idea with them in later sections.

The goal of this thesis is to design and implement a lightweight embedded
time-series storage engine for such devices. The engine stores timestamped
numeric readings and answers time-range queries and simple aggregations
(minimum, maximum, average and count). Incoming readings are appended to a
write-ahead log for durability and collected in a small in-memory buffer. When
the buffer is full, its contents are compressed and written to disk as
immutable, time-partitioned blocks, each carrying summary statistics so that
many queries can skip blocks or be answered without decompressing them. Crash
safety relies on checksums and on making blocks visible only after they are
completely written, and a retention policy can delete the oldest blocks when
the storage budget is reached. The aim is not to replicate an existing
time-series database but to choose a design carefully for systems with limited
RAM and disk space. The engine is intended for developers and researchers who
build IoT and edge-device software and need to record sensor data locally and
analyse it later.
