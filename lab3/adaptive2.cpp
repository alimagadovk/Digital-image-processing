//// Arithmetic coder. Simplest & slowest (demo version)
//#define _CRT_SECURE_NO_WARNINGS
//#include <stdio.h>
//#include <process.h>
//#include <cmath>
//#include <vector>
//
////��� ��������� ������������:	MAX_FREQUENCY * (TOP_VALUE+1) < ULONG_MAX 
////����� MAX_FREQUENCY ������ ���� �����, ��� � 4 ���� ������ TOP_VALUE 
////����� �������� NO_OF_CHARS ������ ���� ����� ������ MAX_FREQUENCY 
//#define BITS_IN_REGISTER	17	
//#define TOP_VALUE			(((unsigned long)1<<BITS_IN_REGISTER)-1)	// 1111...1
//#define FIRST_QTR			((TOP_VALUE>>2) +1)							// 0100...0
//#define HALF				(2*FIRST_QTR)								// 1000...0
//#define THIRD_QTR			(3*FIRST_QTR)								// 1100...0
//#define MAX_FREQUENCY		((unsigned)1<<15)
//#define NO_OF_CHARS			16
//#define EOF_SYMBOL			NO_OF_CHARS			// char-����: 0..NO_OF_CHARS-1
//#define NO_OF_SYMBOLS		(NO_OF_CHARS+1)		// + EOF_SYMBOL
//#define LEVELS_OF_BRIGHTNESS NO_OF_CHARS
//
//#ifdef _WIN32
//#define inline __inline
//#endif
//
//unsigned long			low, high, value;
//int						buffer, bits_to_go, garbage_bits, bits_to_follow;
//unsigned int			cum_freq1[NO_OF_SYMBOLS + 1];
//unsigned int			cum_freq[LEVELS_OF_BRIGHTNESS][NO_OF_SYMBOLS + 1]; //��������� ������ ��������
//unsigned int			*temp_cum_freq;
//// ������������� ������� ��������� ������� s (������ ����������� ��� ���������)
//// ������������ ��� p(s)=(cum_freq[s+1]-cum_freq[s])/cum_freq[NO_OF_SYMBOLS]
//
//FILE* in, * out;
//
//void start_model1(void)
//{ // ���������� ��� ������� � ��������� ������� ��������������� 
//	int i;
//	for (i = 0; i <= NO_OF_SYMBOLS; i++)
//		cum_freq1[i] = i;
//}
//
//void start_model2(void)
//{ // ���������� ��� ������� � ��������� ������� ��������������� 
//	int i, j;
//	for (i = 0; i < LEVELS_OF_BRIGHTNESS; i++)
//		for (j = 0; j <= NO_OF_SYMBOLS; j++)
//			cum_freq[i][j] = j;
//}
//
//
//inline void update_model1(int symbol) 
//{ 
//	if (cum_freq1[NO_OF_SYMBOLS]==MAX_FREQUENCY) 
//	{ // ������������ ��������� ���������, �������� �� � 2 ���� 
//	  // ��� ���-�� ������ ����, ��� ������ � ��� ������
//		int cum = 0, freq = 0;
//		for (int i = 0; i < NO_OF_SYMBOLS; i++)
//		{
//			freq = (cum_freq1[i + 1] - cum_freq1[i] + 1) >> 1;
//			cum_freq1[i] = cum;
//			cum += freq;
//		}
//		cum_freq1[NO_OF_SYMBOLS] = cum;	
//	}
//// ���������� ���������� ������: 
//// ��� ���-�� ������ ����, ��� ������ � ��� ������ 
//	for (int i = symbol + 1; i <= NO_OF_SYMBOLS; i++)
//		cum_freq1[i]++;
//}
//
//inline void update_model2(int symbol)
//{
//	if (temp_cum_freq[NO_OF_SYMBOLS] == MAX_FREQUENCY)
//	{ // ������������ ��������� ���������, �������� �� � 2 ���� 
//	  // ��� ���-�� ������ ����, ��� ������ � ��� ������
//		int cum = 0, freq = 0;
//		for (int i = 0; i < NO_OF_SYMBOLS; i++)
//		{
//			freq = (temp_cum_freq[i + 1] - temp_cum_freq[i] + 1) >> 1;
//			temp_cum_freq[i] = cum;
//			cum += freq;
//		}
//		temp_cum_freq[NO_OF_SYMBOLS] = cum;
//	}
//	// ���������� ���������� ������: 
//	// ��� ���-�� ������ ����, ��� ������ � ��� ������ 
//	for (int i = symbol + 1; i <= NO_OF_SYMBOLS; i++)
//		temp_cum_freq[i]++;
//}
//inline int input_bit(void) // ���� 1 ���� �� ������� �����
//{
//	int t;
//	if (bits_to_go == 0)
//	{
//		buffer = getc(in);	// ��������� ����� �������� �����
//		if (buffer == EOF)	// ������� ����� ������ ������ ��������
//		{
//			// ������� ������� ����������� ������: ��������� 
//			// ������������ �������� ������ ���� EOF_SYMBOL,
//			// �� ������� �� ���� ���� �� ����� � ����� ���������� 
//			// � ����������� �������������, �������� ����� ���� 
//			// (��. ���� for(;;) � ��������� decode_symbol). ��� 
//			// ������ "�����", ������� �� ����� ������� 
//			// ���������� � �� ����� ������ ������
//			garbage_bits++;
//			if (garbage_bits > BITS_IN_REGISTER - 2)
//			{	// ������ ����������� ���������� ����� �������� �����
//				printf("ERROR IN COMPRESSED FILE ! \n");
//				exit(-1);
//			}
//			bits_to_go = 1;
//		}
//		else bits_to_go = 8;
//	}
//	t = buffer & 1;
//	buffer >>= 1;
//	bits_to_go--;
//	return t;
//}
//
//inline void output_bit(int bit) // ����� ������ ���� � ������ ����
//{
//	buffer = (buffer >> 1) + (bit << 7); // � ������� ����� (���� ����)
//	bits_to_go--;
//	if (bits_to_go == 0) // ������� ����� ��������, ����� ������
//	{
//		putc(buffer, out);
//		bits_to_go = 8;
//	}
//}
//inline void output_bit_plus_follow(int bit) // ����� ������ ���������� ���� � ���, ������� ���� ��������
//{
//	output_bit(bit);
//	while (bits_to_follow > 0)
//	{
//		output_bit(!bit);
//		bits_to_follow--;
//	}
//}
//
//void start_encoding(void)
//{
//	bits_to_go = 8;				// �������� ��� � ������� ������ ������
//	bits_to_follow = 0;				// ����� ���, ����� ������� �������
//	low = 0;				// ������ ������� ���������
//	high = TOP_VALUE;		// ������� ������� ���������
//	temp_cum_freq = cum_freq[0];
//}
//void done_encoding(void)
//{
//	bits_to_follow++;
//	if (low < FIRST_QTR)
//		output_bit_plus_follow(0);
//	else
//		output_bit_plus_follow(1);
//	putc(buffer >> bits_to_go, out); // �������� ������������� �����
//}
//
//void start_decoding(void)
//{
//	int i;
//	bits_to_go = 0;				// �������� ��� � ������� ������ �����
//	garbage_bits = 0;				// �������� ����� "��������" ��� � ����� ������� �����
//	low = 0;				// ������ ������� ���������
//	high = TOP_VALUE;		// ������� ������� ���������
//	value = 0;				// "�����"
//	for (i = 0; i < BITS_IN_REGISTER; i++)
//		value = (value << 1) + input_bit();
//	temp_cum_freq = cum_freq[0];
//}
//
//void encode_symbol(int symbol)
//{
//	// �������� ������ ���������
//	unsigned long range;
//	range = high - low + 1;
//	high = low + range * temp_cum_freq[symbol + 1] / temp_cum_freq[NO_OF_SYMBOLS] - 1;
//	low = low + range * temp_cum_freq[symbol] / temp_cum_freq[NO_OF_SYMBOLS];
//	// ����� ��� ������������蠗 ����� ���� ��� ���� �� ������������
//	for (;;)
//	{	// ���������: ������ low < high
//		if (high < HALF) // ������� ���� low � high�� ������� (���)
//			output_bit_plus_follow(0); //����� ������������ �������� ����
//		else if (low >= HALF) // ������� ���� low � high - ���������
//		{
//			output_bit_plus_follow(1);	// ����� �������� ����
//			low -= HALF;				// ����� �������� ���� � 0
//			high -= HALF;				// ����� �������� ���� � 0
//		}
//		else if (low >= FIRST_QTR && high < THIRD_QTR)
//		{/* �������� ������������, �.�.
//			HALF <= high < THIRD_QTR,	i.e. high=10...
//			FIRST_QTR <= low < HALF,	i.e. low =01...
//			����������� ������ �� ����������� ���	*/
//			high -= FIRST_QTR;		// high	=01...
//			low -= FIRST_QTR;		// low	=00...
//			bits_to_follow++;		//����������� ����� (���) ������ ����
//			// ������� ��� ����� ������ �����
//		}
//		else break;		// ��������� ����� ��� ���� 
//		// ������� ��� � low � high �������, ��������� ����� ��� � ������� ������ 
//		low <<= 1;	// ��������� 0
//		high <<= 1;
//		high++;		// ��������� 1
//	}
//}
//
//int decode_symbol(void)
//{
//	unsigned long range, cum;
//	int symbol;
//	range = high - low + 1;
//	// ����� cum - ��� ����� value, ������������� �� ���������
//	// low..high � �������� 0..CUM_FREQUENCY[NO_OF_SYMBOLS]
//	cum = ((value - low + 1) * temp_cum_freq[NO_OF_SYMBOLS] - 1) / range;
//	// ����� ���������, ���������������� ����� cum
//	for (symbol = 0; temp_cum_freq[symbol + 1] <= cum; symbol++);
//	// �������� ������
//	high = low + range * temp_cum_freq[symbol + 1] / temp_cum_freq[NO_OF_SYMBOLS] - 1;
//	low = low + range * temp_cum_freq[symbol] / temp_cum_freq[NO_OF_SYMBOLS];
//	for (;;)
//	{	// ���������� � ������������� ��������� ��������
//		if (high < HALF) {/* c������ ���� low � high - ������� */ }
//		else if (low >= HALF)
//		{	// c������ ���� low � high - ���������, ����������
//			value -= HALF;
//			low -= HALF;
//			high -= HALF;
//		}
//		else if (low >= FIRST_QTR && high < THIRD_QTR)
//		{	// ��������� ��� ��, ��� ��� �����������
//			value -= FIRST_QTR;
//			low -= FIRST_QTR;
//			high -= FIRST_QTR;
//		}
//		else break;	// ��������� ����� ��� ���� 
//		low <<= 1; // ��������� ����� ��� 0
//		high <<= 1;
//		high++;	// ��������� ����� ��� 1
//		value = (value << 1) + input_bit(); // ��������� ����� ��� ����������
//	}
//	return symbol;
//}
//
//void encode(void)
//{
//	int q = 256 / LEVELS_OF_BRIGHTNESS;
//
//	int symbol;
//	start_model1();
//	start_model2();
//	start_encoding();
//	while ((symbol = getc(in)) != EOF)
//	{
//		symbol = (symbol - q / 2) / q;
//		encode_symbol(symbol);
//		update_model1(symbol);
//		update_model2(symbol);
//		temp_cum_freq = cum_freq[symbol];
//	}
//	encode_symbol(EOF_SYMBOL);
//	done_encoding();
//}
//
//void decode(void)
//{
//	int q = 256 / LEVELS_OF_BRIGHTNESS;
//	int symbol;
//	start_model1();
//	start_model2();
//	start_decoding();
//	while ((symbol = decode_symbol()) != EOF_SYMBOL)
//	{
//		update_model1(symbol);
//		update_model2(symbol);
//		temp_cum_freq = cum_freq[symbol];
//		symbol = (symbol * q) + q / 2;
//		putc(symbol, out);
//	}
//}
//
//double entropy1(bool with_eof = 0)
//{
//	double* p;
//	double H = 0;
//	if (with_eof)
//	{
//		p = new double[NO_OF_SYMBOLS];
//		for (int i = 0; i < NO_OF_SYMBOLS; i++)
//		{
//			p[i] = ((double)cum_freq1[i + 1] - (double)cum_freq1[i]) / cum_freq1[NO_OF_SYMBOLS];
//			H += -p[i] * std::log2(p[i]);
//		}
//	}
//	else
//	{
//		p = new double[NO_OF_SYMBOLS - 1];
//		for (int i = 0; i < NO_OF_SYMBOLS - 1; i++)
//		{
//			p[i] = ((double)cum_freq1[i + 2] - (double)cum_freq1[i + 1]) / cum_freq1[NO_OF_SYMBOLS];
//			H += -p[i] * std::log2(p[i]);
//		}
//	}
//	return H;
//}
//
//double entropy2()
//{
//	std::vector<double> table_cond_prob(LEVELS_OF_BRIGHTNESS * LEVELS_OF_BRIGHTNESS);
//	std::vector<double> vect_prob(LEVELS_OF_BRIGHTNESS);
//	std::vector<double> H_cond(LEVELS_OF_BRIGHTNESS);
//	double H = 0;
//	for (int i = 0; i < LEVELS_OF_BRIGHTNESS; i++)
//	{
//		H_cond[i] = 0;
//		for (int j = 0; j < LEVELS_OF_BRIGHTNESS; j++)
//		{
//			table_cond_prob[i * LEVELS_OF_BRIGHTNESS + j] = ((double)cum_freq[i][j + 2] - (double)cum_freq[i][j + 1]) / cum_freq[i][NO_OF_SYMBOLS];
//			H_cond[i] += -table_cond_prob[i * LEVELS_OF_BRIGHTNESS + j] * std::log2(table_cond_prob[i * LEVELS_OF_BRIGHTNESS + j]);
//		}
//		vect_prob[i] = ((double)cum_freq1[i + 2] - (double)cum_freq1[i + 1]) / cum_freq1[NO_OF_SYMBOLS];
//		H += vect_prob[i] * H_cond[i];
//	}
//	return H;
//}
//
//
//
//void _cdecl main(int argc, char** argv)
//{
//	printf("\nArithmetic coder\n");
//	if (argc != 4 || argv[1][0] != 'e' && argv[1][0] != 'd')
//		printf("\nUsage: arcode e|d infile outfile \n");
//	else if ((in = fopen(argv[2], "r+b")) == NULL)
//		printf("\nIncorrect input file\n");
//	else if ((out = fopen(argv[3], "w+b")) == NULL)
//		printf("\nIncorrect output file\n");
//	else
//	{
//		if (argv[1][0] == 'e') encode(); else decode();
//		fclose(in);
//		fclose(out);
//		double H = entropy2();
//		printf("\nH = %f\n", H);
//	}
//}