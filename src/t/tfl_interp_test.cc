#include <iostream>
#include <iterator>
#include <regex>
#include <string>
using namespace std;

#include <nlohmann/json.hpp>
using json = nlohmann::json;

#include "CppUTest/TestHarness.h"

extern unsigned long chg_endian(unsigned long val, int len);

TEST_GROUP(TFLInterpGroup)
{
};

extern const string parse_cmd_line(const string& str, vector<string> &args);

TEST(TFLInterpGroup, ParseCmdLineTest)
{
    string buff("predict img.jpg");

    vector<string> args;
    auto command = parse_cmd_line(buff, args);

    CHECK_COMPARE("predict", ==, command);
    CHECK_EQUAL(1, args.size());
    CHECK_COMPARE("img.jpg", ==, args[0]);
}

struct CmdPacket {
    ssize_t mCount;
    char   *mBuff, _Buff[2048];

    void set_error()
    {
        mCount = ((ssize_t)-1);
        mBuff  = _Buff;
    }
    void write_packet(
    char* cmd)
    {
        mCount = strlen(cmd);
        mBuff  = _Buff;
        if (mCount > sizeof(_Buff)) {
            mCount = ((ssize_t)-1);
        }
        else {
            mBuff[0] = 0xFF & (mCount >> 8);
            mBuff[1] = 0xFF & (mCount);
            memcpy(&mBuff[2], cmd, mCount);
            mCount += 2;
        }
    }
    ssize_t read_packet(
    void* buff,
    size_t count)
    {
        // error or termination
        if (mCount <= 0) { return mCount; }
        
        if (count > mCount) {
            count = mCount;
        }
        memcpy(buff, mBuff, count);
        mCount -= count;
        mBuff  += count;
        return count;
    }
} gCmdPacket;

ssize_t mock_read(int fd, void *buf, size_t count) { return gCmdPacket.read_packet(buf, count); }

extern ssize_t rcv_packet(string& cmd_line);

TEST(TFLInterpGroup, FullReadTest)
{
    gCmdPacket.write_packet("predict img.jpg");
    
    string str;
    ssize_t n = rcv_packet(str);

    CHECK_EQUAL(15, n);
    CHECK_EQUAL("predict img.jpg", str);
}

TEST(TFLInterpGroup, JsonTest)
{
    json j;
    j[1] = 0.994;
    
    CHECK_EQUAL("", j.dump());
}
