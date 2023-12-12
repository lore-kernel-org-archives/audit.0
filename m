Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kxVw7zDg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296E5AB
	for <audit@vger.kernel.org>; Tue, 12 Dec 2023 02:29:06 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hll0028870;
	Tue, 12 Dec 2023 10:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=tJc/FOodJSHcQG0F9yHAqD4iooQS++do2a0zd/mCcHQ=;
 b=kxVw7zDghT/+bZ+HLAPPA9j0iO6O7UOZ3+tratE1gO2WsnGL/P4v/h6q+66/WUJEE7m7
 ac5TVlFFAyxt0tVoVHLl7cVR64Y5gbZdgxjefc3n6JEzH9LCpDBMb9ZcfLKiPmSijl1e
 446mqnyqaX6U5fC5jq9NDETWqJx/CLuokPXvpturYCrjWyX6IISZ8TD/VvCcmm/+IHL2
 pCmDi+S5xSzqYKg78StCue/qxRLeftFjIkQwmBK7eHd8lFA/T4Vi1dUQy4gxGcSbfgr7
 bOVeAs3kGOdcOLrf3A/fdFw/Hf1tcC74Q3U8AdV/N4kXPQ9uat06GRIxZoBKEsC0X5UL Jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d5auq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 10:29:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC9IEgN003222;
	Tue, 12 Dec 2023 10:29:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6cmt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 10:29:03 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCASxHU033207;
	Tue, 12 Dec 2023 10:29:02 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uvep6cmqk-4;
	Tue, 12 Dec 2023 10:29:02 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        audit@vger.kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 2/2] audit: Apply special optimizations
Date: Tue, 12 Dec 2023 11:28:57 +0100
Message-Id: <20231212102857.803984-4-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231212102857.803984-1-haakon.bugge@oracle.com>
References: <20231212102857.803984-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120083
X-Proofpoint-GUID: MBAKxHxuO-Rdt-Yz2-oa3drQzBdL3U9i
X-Proofpoint-ORIG-GUID: MBAKxHxuO-Rdt-Yz2-oa3drQzBdL3U9i

For the most time-consuming function, when running a syscall benchmark
with STIG compliant audit rules:

  Overhead  Command       Shared Object      Symbol
 .........  ............  .................  ........................

    27.62%  syscall_lat   [kernel.kallsyms]  [k] __audit_filter_op

we apply special optimizations, which speeds up the syscall
performance by around 17% on an Intel Cascade Lake system.

We run "perf stat -d -r 5 ./syscall_lat", where syscall_lat is a C
application that measures average syscall latency from getpid()
running 100 million rounds.

Between each perf run, we reboot the system and waits until the last
minute load is less than 1.0.

We boot the kernel, v6.6-rc4, with "mitigations=off", in order to
amplify the changes in the audit system.

Let the base kernel be v6.6-rc4 with booted with "audit=1" and
"mitigations=off" and with the commit "audit: Vary struct audit_entry
alignment" on an Intel Cascade Lake system. The following three
metrics are reported, nanoseconds per syscall, L1D misses per syscall,
and finally Intructions Per Cycle, ipc.

Base vs. base + this commit gives:

ns per call:
  min avg max   pstdev
- 203 203 209 0.954149
+ 173 173 178 0.884534

L1d misses per syscall:
     min    avg    max   pstdev
-  0.012  0.103  0.817 0.238352
+  0.010  0.209  1.235 0.399416

ipc:
    min    avg    max   pstdev
- 2.320  2.329  2.330 0.003000
+ 2.430  2.436  2.440 0.004899

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 kernel/auditsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6f0d6fb6523fa..84d0dfe75a4ac 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -822,6 +822,7 @@ static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
  * parameter can be NULL, but all others must be specified.
  * Returns 1/true if the filter finds a match, 0/false if none are found.
  */
+#pragma GCC optimize("unswitch-loops", "align-loops=16", "align-jumps=16")
 static int __audit_filter_op(struct task_struct *tsk,
 			   struct audit_context *ctx,
 			   struct list_head *list,
@@ -841,6 +842,7 @@ static int __audit_filter_op(struct task_struct *tsk,
 	}
 	return 0;
 }
+#pragma GCC reset_options
 
 /**
  * audit_filter_uring - apply filters to an io_uring operation
-- 
2.39.3

