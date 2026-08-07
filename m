Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E870808
	for <audit@vger.kernel.org>; Fri,  7 Aug 2026 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786064510; cv=none; b=CNWY3sF7KWmKoVfUldrQSRBumPx9oYVK/Zag0ZvSLUgTWgu7L3gHlGy3bCnl1R5UoZ04imettWa+Uxzo44lWM5OZtlllOO+qHXfn/7rBVpidQH7O1KquS31geCPSd2JxZP128y75x6klJTMOgjve8Xwax6fh/25FdOH9d5efwnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786064510; c=relaxed/simple;
	bh=5MlwxZW6swiSLCczpbu3RjCTjMOtxNuISAYVxZ1MH5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdfZ1drwZbxXLYyvgRNd2nMirc5l5WLdhCQyfae2bFl/P+mcbEt/IKxhP1QctBRp9+fXiV56pAkmiIu0j7MzqSLJ2O+x1dg286Dk24leF9SFmZk+FJ3Jp4sOmAQEm151AwakOSKJbmZyftQAUYmXqZbUSZ9C+eM5bhzYAeRRmfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2IV0H0P; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2IV0H0P"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceaf8a1265so41693865ad.2
        for <audit@vger.kernel.org>; Thu, 06 Aug 2026 18:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786064508; x=1786669308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pwP36o17QkWQ0PjVr8FVFT3lgFW/hOoyQfxT67LFwVA=;
        b=V2IV0H0PzOybZ0GHI1Pl2oDhaq2aOW5BGTTCsC/EqpT0DXh81WAXwG7Km1IXOJBudc
         FCy0WT6CjIB1bJC4tJmpekFmiafPfoJHBY60Uw1fbrXu3jJNAO8YD8ioAL9iimzc8/rB
         2pDZQx8foZZPpeXPXk8Wly7Y9b9D62pCP9oMc8i1AZq1C+HEDCHzAGeYig5EIVdlDKRS
         Ojz+4zlnYTNDA2A39qhL90NaVuL4HAfWkBZgQzcS6fn8IfRdYTGSeKjMkgkJmZcYEwK9
         idbtKwwrjlckukTGXtdGf80ziBXp2/aqlM1jhE/eAhVkQQ8K9WhD8MzaeIhFODeWLMjK
         TYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786064508; x=1786669308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pwP36o17QkWQ0PjVr8FVFT3lgFW/hOoyQfxT67LFwVA=;
        b=mnNyn0VbJ+zxRMIX1TbIYowcGEvVRIt7KuRcIJD73nX0bfnp1sCrng01kwAQtXg9Rx
         LnOWADbolXCaoWwATEoQeCd+cheGIxBSre9xhsXfJRTDlz8act/IDGgpin/WedOYcqLI
         zERTQ+LLakZHxihT+Ow++KDNF2DFZoWyzGv+K5c6JK6e4+h4wFkmIYF/hxzPGW0mMeSe
         j85yTNx4MWxtyxho7KCEls35FbknZWT1NALj3GXNCjvXwU0QTeS/XmGgjpTpOnd4WwQA
         r/X/4ZZkODNOG0/UkLWTdiIjLEilB9yxCxjbz1Dvj37H/NhI1QEXgPbzrpWfPSz9D8y6
         D9AQ==
X-Forwarded-Encrypted: i=1; AHgh+RoG+gV+BakNKYrb4/NBRVLYMoCNr8EEGA+Xc06qwX24PkJ0b8OoFHaqIUoW15VaSnoNAgxpNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHul5v4P+kOPoGiYtw6zUAC6wEi4hG4qtoDR0O8BcpG4MHOfPX
	nA8hs1/i8aEY8mm2XnRwssRtNSIbBeVbI8LTHLOE5V2Rpt+3ZrfbXgV6
X-Gm-Gg: AR+sD11Jd1GiXuDEsgvhx40x2QbUtZ1PVRhoUtBXQB00Y5cG/aybicgxaomZ7maXFry
	ZF0v8KM6u8bhYpqDgz0k0D1TI1Wz2v3tF8EouxLMSY/VpGfAT7LLVeNAJpxsbgb4Wi+FHBLiMpU
	AIrKKVufhpjQ2bzj0xSAO/mav9uzhgiGXABNc99f0dnbdoa19ri9EG5xl8BMna73exoCH+dByiA
	kR7so4/Q9fUX6YSJ6sDjpM+y+l+dvKgY7VgMB+v/kEjkrsdJ4ovpiBUkZJovfRr6vIurdJW3wyD
	Jw8iZwbbM9m5Dkp0s4VZtzmjRuVpvbyAReuF4PqjVwBdWZDnHxdqxQZSJy50pUkJt7gZ8ftvu2X
	F38Ehfp6n6Nx7VkRBaAAIqxi/8JtnOUudBUeWbgsEcnb8ELeffFNyLXxN+I4z2yAaMiZK6y6+bX
	O7VnaGQhafBP7xj6iBsZoGhwcJ0kBZNLdiWF1Kwbub31sr5nWfiMkVQQr+lRb8wWC5ce175RuKH
	ak4xw1+WC/7eB7//mljJy0vIfbz4p9U/ZM=
X-Received: by 2002:a17:902:dac1:b0:2c0:e5ee:f554 with SMTP id d9443c01a7336-2d0ca71b3d7mr209247785ad.8.1786064507867;
        Thu, 06 Aug 2026 18:01:47 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14d7684f8sm1527725ad.33.2026.08.06.18.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 18:01:47 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Date: Thu, 06 Aug 2026 18:01:19 -0700
Subject: [PATCH 1/3] selftests/audit: Add syscall overhead benchmark
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-audit-v1-1-ddd0d94ff0b6@gmail.com>
References: <20260806-audit-v1-0-ddd0d94ff0b6@gmail.com>
In-Reply-To: <20260806-audit-v1-0-ddd0d94ff0b6@gmail.com>
To: Shuah Khan <shuah@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Eric Paris <eparis@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Amy Griffis <amy.griffis@hp.com>
Cc: Stanislav Kinsburskii <skinsburskii@gmail.com>, 
 Frank Hofmann <hofmann@deshaw.com>, Noah Orlando <orlandon@deshaw.com>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 audit@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786064505; l=10426;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=5MlwxZW6swiSLCczpbu3RjCTjMOtxNuISAYVxZ1MH5c=;
 b=0u1iAu0ZGuodPxXfccaUhAWuBCzIPPS+0TUNC592bEADuck1TGFnAu/MqVhBTREhuWBytf8g0
 OcxVotg5x4MBJI99zEQy5ehUXt5V5UrgG4+qkm2H6nKDrE8HNHdXFTs
X-Developer-Key: i=skinsburskii@gmail.com; a=ed25519;
 pk=bDpriHBYgeTdkIDweZDCemxsU93neJBOCn3YLIuJpnE=

Add a microbenchmark which repeatedly invokes getpid(2) and reports the
per-operation latency across multiple repetitions. The workload avoids
filesystem and other syscall-specific work so the fixed audit syscall
overhead remains visible.

The benchmark deliberately leaves audit policy management to the caller.
This permits comparisons with increasing numbers of unrelated exit rules
and with automatically removed watch or tree rules without modifying an
existing policy unexpectedly.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 MAINTAINERS                                 |   1 +
 tools/testing/selftests/Makefile            |   1 +
 tools/testing/selftests/audit/.gitignore    |   2 +
 tools/testing/selftests/audit/Makefile      |   9 ++
 tools/testing/selftests/audit/README        |  30 ++++
 tools/testing/selftests/audit/audit_bench.c | 227 ++++++++++++++++++++++++++++
 6 files changed, 270 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d52c224eabaf..6d87387de0cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4365,6 +4365,7 @@ F:	include/linux/audit_arch.h
 F:	include/uapi/linux/audit.h
 F:	kernel/audit*
 F:	lib/*audit.c
+F:	tools/testing/selftests/audit/
 K:	\baudit_[a-z_0-9]\+\b
 
 AUTOFDO BUILD
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 84343fd1e354..fb2dae9d4018 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TARGETS += acct
+TARGETS += audit
 TARGETS += alloc_tag
 TARGETS += alsa
 TARGETS += amd-pstate
diff --git a/tools/testing/selftests/audit/.gitignore b/tools/testing/selftests/audit/.gitignore
new file mode 100644
index 000000000000..1138c94bdce5
--- /dev/null
+++ b/tools/testing/selftests/audit/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+audit_bench
diff --git a/tools/testing/selftests/audit/Makefile b/tools/testing/selftests/audit/Makefile
new file mode 100644
index 000000000000..ce7e06725fd0
--- /dev/null
+++ b/tools/testing/selftests/audit/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -O2 -Wall -Wextra
+LDLIBS += -lm
+
+TEST_GEN_PROGS_EXTENDED := audit_bench
+TEST_FILES := README
+
+include ../lib.mk
diff --git a/tools/testing/selftests/audit/README b/tools/testing/selftests/audit/README
new file mode 100644
index 000000000000..b40155808dcf
--- /dev/null
+++ b/tools/testing/selftests/audit/README
@@ -0,0 +1,30 @@
+Audit syscall overhead benchmark
+================================
+
+Build it with:
+
+  make -C tools/testing/selftests/audit
+
+The benchmark repeatedly invokes getpid(2). It does not install or remove
+audit rules. Configure the policy explicitly with auditctl, then run the same
+workload for each policy.
+
+For example:
+
+  sudo auditctl -a always,exit -F arch=b64 -S openat
+  sudo ./tools/testing/selftests/audit/audit_bench
+  sudo auditctl -d always,exit -F arch=b64 -S openat
+
+The getpid workload exposes the fixed per-syscall audit overhead without
+adding filesystem work. Useful comparisons are no rules, increasing numbers
+of unrelated syscall rules, and a clean state versus one where a watch or
+tree rule was removed automatically. Keep the machine idle, pin with --cpu
+when possible, and collect profiles with perf stat and perf record. Report
+the kernel commit, CPU model, audit status, policy and auditd state with every
+comparison.
+
+After printing each repetition, the benchmark reports the median, arithmetic
+mean, sample standard deviation, coefficient of variation and observed range
+of per-operation latency across repetitions. The coefficient of variation
+makes noisy runs easy to identify; increase the iteration count or investigate
+system noise when it is high.
diff --git a/tools/testing/selftests/audit/audit_bench.c b/tools/testing/selftests/audit/audit_bench.c
new file mode 100644
index 000000000000..89c19c03817c
--- /dev/null
+++ b/tools/testing/selftests/audit/audit_bench.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microbenchmark for Linux audit syscall overhead.
+ *
+ * This program does not configure audit.  Install rules manually to compare
+ * the same workload under different policies.
+ */
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <errno.h>
+#include <getopt.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <math.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/syscall.h>
+#include <time.h>
+#include <unistd.h>
+
+#define DEFAULT_ITERATIONS	10000000ULL
+#define DEFAULT_REPETITIONS	10
+
+static int compare_double(const void *left, const void *right)
+{
+	const double a = *(const double *)left;
+	const double b = *(const double *)right;
+
+	return (a > b) - (a < b);
+}
+
+static void print_summary(double *samples, unsigned int repetitions)
+{
+	double mean = 0.0;
+	double squared_deviations = 0.0;
+	double median;
+	double stddev;
+	unsigned int i;
+
+	for (i = 0; i < repetitions; i++)
+		mean += samples[i];
+	mean /= repetitions;
+
+	for (i = 0; i < repetitions; i++) {
+		double deviation = samples[i] - mean;
+
+		squared_deviations += deviation * deviation;
+	}
+	stddev = repetitions > 1 ?
+		sqrt(squared_deviations / (repetitions - 1)) : 0.0;
+
+	qsort(samples, repetitions, sizeof(*samples), compare_double);
+	if (repetitions % 2)
+		median = samples[repetitions / 2];
+	else
+		median = (samples[repetitions / 2 - 1] +
+			  samples[repetitions / 2]) / 2.0;
+
+	printf("==========================================\n");
+	printf("summary (ns/op): median=%.f", median);
+	printf(" mean=%.f", mean);
+	printf(" stddev=%.f (%.f%%)", stddev,
+	       mean ? stddev * 100.0 / mean : 0.0);
+	printf(" range=%.f..%.f\n",
+	       samples[0], samples[repetitions - 1]);
+}
+
+static void usage(const char *program)
+{
+	printf("Usage: %s [OPTIONS]\n", program);
+	printf("\n");
+	printf("Options:\n");
+	printf("  -c, --cpu CPU          pin the benchmark to CPU\n");
+	printf("  -h, --help             show this help\n");
+	printf("  -n, --iterations N     measured operations per repetition\n");
+	printf("                         (default: %llu)\n",
+	       DEFAULT_ITERATIONS);
+	printf("  -r, --repetitions N    number of measured repetitions\n");
+	printf("                         (default: %d)\n",
+	       DEFAULT_REPETITIONS);
+	printf("  -w, --warmup N         warm-up operations (default N/10)\n");
+}
+
+static uint64_t parse_u64(const char *value, const char *name)
+{
+	uint64_t parsed;
+	char *end;
+
+	if (*value < '0' || *value > '9')
+		errx(EXIT_FAILURE, "invalid %s: %s", name, value);
+
+	errno = 0;
+	parsed = strtoull(value, &end, 0);
+	if (errno || *value == '\0' || *end != '\0')
+		errx(EXIT_FAILURE, "invalid %s: %s", name, value);
+
+	return parsed;
+}
+
+static unsigned int parse_uint(const char *value, const char *name)
+{
+	uint64_t parsed = parse_u64(value, name);
+
+	if (parsed > UINT_MAX)
+		errx(EXIT_FAILURE, "%s is too large: %s", name, value);
+
+	return parsed;
+}
+
+static void pin_to_cpu(unsigned int cpu)
+{
+	cpu_set_t set;
+
+	if (cpu >= CPU_SETSIZE)
+		errx(EXIT_FAILURE, "CPU must be less than %d", CPU_SETSIZE);
+
+	CPU_ZERO(&set);
+	CPU_SET(cpu, &set);
+	if (sched_setaffinity(0, sizeof(set), &set))
+		err(EXIT_FAILURE, "sched_setaffinity(%u)", cpu);
+}
+
+static uint64_t elapsed_ns(const struct timespec *start,
+			   const struct timespec *end)
+{
+	return (end->tv_sec - start->tv_sec) * 1000000000ULL +
+		end->tv_nsec - start->tv_nsec;
+}
+
+static void run_getpid(uint64_t iterations)
+{
+	uint64_t i;
+
+	for (i = 0; i < iterations; i++)
+		syscall(SYS_getpid);
+}
+
+int main(int argc, char **argv)
+{
+	static const struct option options[] = {
+		{ "cpu", required_argument, NULL, 'c' },
+		{ "help", no_argument, NULL, 'h' },
+		{ "iterations", required_argument, NULL, 'n' },
+		{ "repetitions", required_argument, NULL, 'r' },
+		{ "warmup", required_argument, NULL, 'w' },
+		{ }
+	};
+	uint64_t iterations = DEFAULT_ITERATIONS;
+	uint64_t warmup = 0;
+	unsigned int repetitions = DEFAULT_REPETITIONS;
+	unsigned int cpu = 0;
+	bool warmup_set = false;
+	bool cpu_set = false;
+	double *samples;
+	int option;
+	unsigned int repetition;
+
+	while ((option = getopt_long(argc, argv, "c:hn:r:w:", options,
+				     NULL)) != -1) {
+		switch (option) {
+		case 'c':
+			cpu = parse_uint(optarg, "CPU");
+			cpu_set = true;
+			break;
+		case 'h':
+			usage(argv[0]);
+			return EXIT_SUCCESS;
+		case 'n':
+			iterations = parse_u64(optarg, "iteration count");
+			break;
+		case 'r':
+			repetitions = parse_uint(optarg, "repetition count");
+			break;
+		case 'w':
+			warmup = parse_u64(optarg, "warm-up count");
+			warmup_set = true;
+			break;
+		default:
+			usage(argv[0]);
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (optind != argc)
+		errx(EXIT_FAILURE, "unexpected positional argument: %s",
+		     argv[optind]);
+	if (!iterations || !repetitions)
+		errx(EXIT_FAILURE, "iterations and repetitions must be nonzero");
+	if (!warmup_set)
+		warmup = iterations / 10;
+	if (cpu_set)
+		pin_to_cpu(cpu);
+
+	samples = calloc(repetitions, sizeof(*samples));
+	if (!samples)
+		err(EXIT_FAILURE, "calloc(samples)");
+
+	printf("getpid iterations=%" PRIu64 " warmup=%" PRIu64
+	       " repetitions=%u\n", iterations, warmup, repetitions);
+
+	run_getpid(warmup);
+	for (repetition = 0; repetition < repetitions; repetition++) {
+		struct timespec start, end;
+		uint64_t duration;
+		double ns_per_operation;
+
+		if (clock_gettime(CLOCK_MONOTONIC_RAW, &start))
+			err(EXIT_FAILURE, "clock_gettime(start)");
+		run_getpid(iterations);
+		if (clock_gettime(CLOCK_MONOTONIC_RAW, &end))
+			err(EXIT_FAILURE, "clock_gettime(end)");
+
+		duration = elapsed_ns(&start, &end);
+		ns_per_operation = (double)duration / iterations;
+		samples[repetition] = ns_per_operation;
+		printf("%u: %.2f ns/op\n", repetition + 1,
+		       ns_per_operation);
+	}
+
+	print_summary(samples, repetitions);
+	free(samples);
+	return EXIT_SUCCESS;
+}

-- 
2.43.0

