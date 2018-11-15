package main

import (
	"fmt"
	"syscall"

	"golang.org/x/sys/unix"
)

func main() {

	err := unix.Mlockall(unix.MCL_CURRENT | unix.MCL_FUTURE)

	switch err {
	case nil:
		fmt.Println("Great Success!")
	case syscall.ENOMEM:
		fmt.Println("ENOMEM: nonzero RLIMIT_MEMLOCK soft resource limit")
	case syscall.EPERM:
		fmt.Println("EPERM : caller not privileged")
	default:
		se := err.(syscall.Errno)
		fmt.Printf("%v:%s", uintptr(se), err)
	}
}