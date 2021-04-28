PROJ_DIR=${PWD}
SRC_DIR=${PROJ_DIR}/src
INC_DIR=${PROJ_DIR}/include
BIN_DIR=${PROJ_DIR}/bin
BUILD_DIR=${PROJ_DIR}/build

OBJS= ${BUILD_DIR}/foo.o ${BUILD_DIR}/goo.o ${BUILD_DIR}/myapp.o

CFLAGS= -g -Wall # -g : 컴파일 시 디버깅 옵션, –Wall : 워닝 많이 출력
SRCS := ${shell find ${SRC_DIR} -name "*.c"}

.SUFFIXES: .o .c #중요하게 생각하는 확장자라는 것 알려줌

all: dep ${BIN_DIR}/myapp  # 제일 처음 시작되는 타겟

${BIN_DIR}/myapp: ${OBJS}
	gcc ${CFLAGS} -o ${BIN_DIR}/myapp ${OBJS}

${BUILD_DIR}/%.o: ${SRC_DIR}/%.c
	gcc ${CFLAGS} -c $< -I${INC_DIR} -o $@

dep: .depend

.depend: ${SRCS}  # .depend 파일은 srcs에 의존
	rm -f ./.depend
	gcc ${CFLAGS} -I${INC_DIR} -M $^ > ./.depend

include ./.depend

clean:
	rm -f ${BUILD_DIR}/*.o
	rm -f ${BIN_DIR}/*
	rm -f ./.depend
