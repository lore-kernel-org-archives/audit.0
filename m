Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63A3DC4C7
	for <audit@vger.kernel.org>; Tue, 21 Apr 2026 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776797970; cv=none; b=RvSOmMoe3KcQyxg3Nhm8kxOLzuL91Ty9OnizMVzRwUi/vZVENtSGkNfFFKXS2Ps32Bt6cKuHylPAnDU0YhRTLTHrqBaVgI5djgB5SbkOcw4E8Xx9KWWMmSKLBsCctJtnjQg//1Xew7NewS64K8iOTn2XkT4q41LrALfDHzqg38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776797970; c=relaxed/simple;
	bh=+HRh4+n0AI/ar7s7zwX5X37Yb156TCAjzuwUxzbc6Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hopkq0Qj574k0nECqqYDSj41bD7j4MdN1ljhfRfyG6sXIWz8UfC1a7wtZre1aoLAvkHn+hIvtl87iHmFOT77ejEYJgfmS+VQlmR99rDwjNS5Mo8dePkl3D8nD06U+WTVatfDRe4lZwETadSv2TUeingxQ8Ig6q0rbWxhXQVm/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAAIXNWL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAAIXNWL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776797967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HRh4+n0AI/ar7s7zwX5X37Yb156TCAjzuwUxzbc6Lo=;
	b=CAAIXNWLtwRxVlf5YEky/q2PZVBr7o/Nv5PuGVpBQgXYyXp7SlgPEcf9/V8zmSwvNR2+5J
	hoyRFSUUEnCfHeur2b7wsjOJd+1b4MM2NiFb6DqH08iW5qmUpjuTMqsd/8XG3FZUWpRiw9
	jevvPxrOTzpUy0hdIlg0Z2xM3YeJcr0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-RMcnrjK2PjKkC56nr4bcNQ-1; Tue,
 21 Apr 2026 14:59:21 -0400
X-MC-Unique: RMcnrjK2PjKkC56nr4bcNQ-1
X-Mimecast-MFC-AGG-ID: RMcnrjK2PjKkC56nr4bcNQ_1776797960
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6102F180036E;
	Tue, 21 Apr 2026 18:59:19 +0000 (UTC)
Received: from fedora (unknown [10.44.32.56])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 010D01800351;
	Tue, 21 Apr 2026 18:59:14 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 21 Apr 2026 20:59:18 +0200 (CEST)
Date: Tue, 21 Apr 2026 20:59:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Will Drewry <wad@chromium.org>,
	Eric Paris <eparis@redhat.com>,
	Kusaram Devineni <kusaram@devineni.in>,
	Max Ver <dudududumaxver@gmail.com>,
	Paul Moore <paul@paul-moore.com>, audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] seccomp: drop syscall exit events for rejected
 syscalls
Message-ID: <aefJAYnzZT-zhif5@redhat.com>
References: <aeT6T7ZJ45yAtdZs@redhat.com>
 <aeT6dasGDZYPMQ_h@redhat.com>
 <202604210951.7FFD917D@keescook>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202604210951.7FFD917D@keescook>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: yKFhcN_uTnYiYt5lFD7CCjY0sXFboQA4zdijxOFjT7Y_1776797960
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 04/21, Kees Cook wrote:
>
> On Sun, Apr 19, 2026 at 05:53:25PM +0200, Oleg Nesterov wrote:
> > seccomp_nack_syscall() calls syscall_rollback(), which means that the
> > syscall exit path sees the original syscall number as the return value.
> >
> > This confuses audit_syscall_exit(), trace_syscall_exit(), and ptrace,
> > causing them to report completely bogus syscall exit events.
> >
> > Add a new SYSCALL_WORK_SECCOMP_EXIT flag set by seccomp_nack_syscall(),
> > and change syscall_exit_work() to return early if this flag is set. After
> > all, this syscall was never actually executed.
>
> I think this looks good.

Great,

> I'd like to cover the non-generic syscall
> paths, though, too?

OK, I'll try to make the "extended" V2 soon.

> (Otherwise we immediately have a behavioral
> difference between e.g. x86 and arm64.)

Yes, yes, agreed, I even mentioned this in 0/2.

Thanks!

Oleg.

