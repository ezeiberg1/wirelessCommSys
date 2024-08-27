# Modeling an over-the-air communication system using Quadrature Phase Shift Keying (QPSK) - 2024

In this model, the received signal is filtered using an SRRC pulse shape. Cross-correlation and phase syncing are applied to remove any lags/shifts that resulted from transmission. The message header is removed and the signal is downsampled to get the vector that will be used for decision making. Symbol decisions are made by chosing the closest QPSK symbol in the constellation diagram. These symbols are converted to bits, which can then be converted to the text message.
