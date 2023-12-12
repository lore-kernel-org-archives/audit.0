Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JKjv6fYA"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC32F7
	for <audit@vger.kernel.org>; Tue, 12 Dec 2023 02:29:19 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hh1r004073;
	Tue, 12 Dec 2023 10:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=Mc6avwsJwUdwv06HUKlEkdrvcvLbKRHmxiNe/zxUa8U=;
 b=JKjv6fYAO+s8NAodJKgJRzfQqdEvEDRNDq86Pq/GA1NNdf0WuY5nkLfHpDPGFzltDup7
 T2JsnlX01sW7s9w8GJ9TvycoB9F+2uAgrEK5m2x7NmOw7UpwKKV6MNkLuTEh6TJqQiir
 3yokGbSrGInxLcEbbVFTbzgggSvpybWSqjtDw/rvltegv4v71visugv5FagX39QSREUC
 RgQ7L+tG77fKOvQvjkXEzD+C7Lpau04pu6mhixP5Q4ppdTSigB0xxiUDv0O8gA63w3/s
 E0mvOz9w6j13obhOlO9pTk7wTV8qlsIaLnifPdtwRHyXGTlW9H4CNF4MPZvd/wmdtPvB zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu5939-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 10:29:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC95OqQ003177;
	Tue, 12 Dec 2023 10:29:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6cmrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 10:29:00 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCASxHQ033207;
	Tue, 12 Dec 2023 10:29:00 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uvep6cmqk-2;
	Tue, 12 Dec 2023 10:29:00 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        audit@vger.kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 1/2] audit: Vary struct audit_entry alignment
Date: Tue, 12 Dec 2023 11:28:55 +0100
Message-Id: <20231212102857.803984-2-haakon.bugge@oracle.com>
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
X-Proofpoint-GUID: yFg3laE4T9lPTOKeSu4z9Z74IHVuU50V
X-Proofpoint-ORIG-GUID: yFg3laE4T9lPTOKeSu4z9Z74IHVuU50V

We allocate struct audit_entry using kzalloc() which aligns the
structure at its natural boundary and so uses the kmalloc-512
SLAB.

That means that the lower order 9 bits are equal for these allocations.
Which on architectures with limited L1D cache-sets width would cause
conflict misses.

With STIG compliant audit rules, up-to 26 L1D misses per syscall have
been observed. This, of course, varies from boot to boot.

Fix this by using a kmem_cache aligned at cacheline width, which
greatly increases the entropy in the lower order VA bits. With this
fix, we observe a maximum of 0.8 misses per syscall using the same set
of audit rules.

Testing: run "perf stat -d -r 5 ./syscall_lat", where syscall_lat is a
simple getpid() loop, running 100 million rounds. This test is run 10
times, with a reboot in between. After each reboot, we wait until
the last minute load is less than 1.0.

We boot the kernel, v6.6-rc4, with "mitigations=off", in order to
amplify the changes in the audit system.

Base vs. base + this commit gives:

ns per call:
  min avg max   pstdev
- 205 210 227 6.402000
+ 203 203 209 0.954149

L1d misses per syscall:
    min    avg    max   pstdev
- 3.147 12.017 26.045 6.568284
+ 0.012  0.103  0.817 0.238352

ipc:
    min    avg    max   pstdev
- 2.090  2.259  2.300 0.060075
+ 2.320  2.329  2.330 0.003000

The above metrics are all improved, and the L1D misses per syscall has
a significant reduction.

Co-developed-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 kernel/auditfilter.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 8317a37dea0bb..b7597a63a3950 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -80,6 +80,7 @@ static void audit_free_lsm_field(struct audit_field *f)
 	}
 }
 
+static struct kmem_cache *entry_cache;
 static inline void audit_free_rule(struct audit_entry *e)
 {
 	int i;
@@ -93,7 +94,7 @@ static inline void audit_free_rule(struct audit_entry *e)
 			audit_free_lsm_field(&erule->fields[i]);
 	kfree(erule->fields);
 	kfree(erule->filterkey);
-	kfree(e);
+	kmem_cache_free(entry_cache, e);
 }
 
 void audit_free_rule_rcu(struct rcu_head *head)
@@ -108,13 +109,20 @@ static inline struct audit_entry *audit_init_entry(u32 field_count)
 	struct audit_entry *entry;
 	struct audit_field *fields;
 
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry_cache) {
+		entry_cache = kmem_cache_create("audit_entry", sizeof(*entry), 0,
+						SLAB_HWCACHE_ALIGN, NULL);
+		if (!entry_cache)
+			return NULL;
+	}
+
+	entry = kmem_cache_zalloc(entry_cache, GFP_KERNEL);
 	if (unlikely(!entry))
 		return NULL;
 
 	fields = kcalloc(field_count, sizeof(*fields), GFP_KERNEL);
 	if (unlikely(!fields)) {
-		kfree(entry);
+		kmem_cache_free(entry_cache, entry);
 		return NULL;
 	}
 	entry->rule.fields = fields;
-- 
2.39.3

