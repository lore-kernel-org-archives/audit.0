Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ric0Z6BP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5474A6
	for <audit@vger.kernel.org>; Tue, 12 Dec 2023 02:29:02 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hpaG021911;
	Tue, 12 Dec 2023 10:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=jPCSxE5Uu9MRojr0nHSf40niePA/lrdFtggAznv+Ksw=;
 b=Ric0Z6BPDHA7BMxyYlPza2SuYuV2JQWLNG8K7Q5HICITiSPqr7Wbdl2ib5Wiu2dMZ+nH
 KrzZxzgtzDaNfN4RY8c9AHT2GELB3xbChQ8yysPo8SXiOdJx5Geqn3nnDHLSU0f6UTht
 AAjfKSGzUd+19hpmVybO1U2kAXKfVEvEdprvntLtQy/9sxW8k8yV4ez9Gw8WZP5Vg2B8
 Nybyg3Pa/8bf+3JME3mD6hdC/E28Jo+hcYvCGl2Wk5bqftL804o5GMrFXuVTnzfEquIF
 hD2YeXGvKsbzGTHKKf0hBUjDeGmQ0mMooLc2wFV2nc0+/YgjoZiufEIX2g7TzmJI7SfJ ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3kjxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 10:29:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC9A4Zu003210;
	Tue, 12 Dec 2023 10:28:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6cmr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 10:28:59 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCASxHO033207;
	Tue, 12 Dec 2023 10:28:59 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uvep6cmqk-1;
	Tue, 12 Dec 2023 10:28:59 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        audit@vger.kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 0/2] audit: Further reduce syscall latency
Date: Tue, 12 Dec 2023 11:28:54 +0100
Message-Id: <20231212102857.803984-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.39.3
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
 malwarescore=0 mlxscore=0 mlxlogscore=787 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120083
X-Proofpoint-ORIG-GUID: CKXmaDOK0uZ-1o4Hh2HUu23fFc2hUnUS
X-Proofpoint-GUID: CKXmaDOK0uZ-1o4Hh2HUu23fFc2hUnUS

On an Intel Cascade Lake, booted with "audit=0" and "mitigations=off",
syscall latency in nanoseconds over 10 reboots and 5 runs is:

getpid() latency:
Boot parameters           kernel            min    avg     max      pstdev
                                           (ns)   (ns)    (ns)        (ns)

audit=0, mitigations=off  v6.6-rc4           55    55       58    0.797245
audit=1, mitigations=off  v6.6-rc4          205   210      227    6.402000
audit=1, mitigations=off  v6.6-rc4+[1]      203   203      209    0.954149
audit=1, mitigations=off  v6.6-rc4+[1]+[2]  173   173      178    0.884534

So, audit contributes significantly to the cost of a system call.

This series, hopefully applicable to audit/next (if accepted), reduces
the syscall latency by a decent 21% on an Intel Cascade Lake system.

The above numbers are derived using the same methodology as mentioned
in the commit messages.

The first commit, "audit: Vary struct audit_entry alignment", fixes a
huge L1D miss ratio and greatly reduces the variability on the three
metrics, nanoseconds per syscall, L1D misses per syscall, and
Instructions per Cycle (ipc). It does not greatly reduce on the
syscall latency, only a decent 3.5% reduction. But, it serves as a
pre-requisite for the second commit, "audit: Apply codegen
optimizations".

Please review.

Håkon Bugge (2):
[1] audit: Vary struct audit_entry alignment
[2] audit: Apply codegen optimizations

 kernel/auditfilter.c | 14 +++++++++++---
 kernel/auditsc.c     |  2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

--
2.39.3

