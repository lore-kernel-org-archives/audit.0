Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CDB30F95C
	for <audit@vger.kernel.org>; Mon, 10 Aug 2026 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786395001; cv=none; b=eSfPW3IRDXRRhrQLMeCvJqFs3Nss/5jftlrLjAI3SbRTmWXSlKms9Z38/w6EAQNJkP8Dp5GLeFaBrCZY9tUXaOLrDedICtvgQZP9fWlYvGtOPqJeDQ9FfuGihwlwW6WIh3hmeLS+vkPTYcfJ45Rj7n4v0q8Q2j64uqAaiFSnobs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786395001; c=relaxed/simple;
	bh=A7jf9tU/SC9eXUsdjE1P2Ut7bn9Q+lSSmZ64XKufwdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4VWB7sBw8f+gVGHjqoEQKkbmeq/ksIW/E6/oEi4Iw5VtWUTdiCcN6Olc5h1vTEhUcFMiWbP7lSa/aalWdszI3ob2E+kTbLAV7yoXtj3wEHt2RAOleqHjd+GhhWSMmc7YeB5iZ0L46sDZsY2H90nuiLK9I4OEbulSdHeu5S65Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/aOwBc9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/aOwBc9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786394998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CgStpdtwmcx/2havoB3iiNK5i92qVfh1v3jKyYVEis=;
	b=J/aOwBc9XyZDJ+66hNjUOxiRXEjzagMiIIWuOf5i5ked3A87nGjnZqhORriLYWqP+8ClNW
	Ba3pCX3oRXJun5HtbtISI+or6OAo45GXZoRDun8M7snbaXlBOi6P/d1tRzVQOI3zPv9YxM
	CarEcjgMfdMM9vGixAHPbVzyyAnypAY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-CF5K_JAJP5mkPu8KkLkqgw-1; Mon, 10 Aug 2026 16:49:57 -0400
X-MC-Unique: CF5K_JAJP5mkPu8KkLkqgw-1
X-Mimecast-MFC-AGG-ID: CF5K_JAJP5mkPu8KkLkqgw_1786394996
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15ff68c858so208013966b.0
        for <audit@vger.kernel.org>; Mon, 10 Aug 2026 13:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786394996; x=1786999796;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8CgStpdtwmcx/2havoB3iiNK5i92qVfh1v3jKyYVEis=;
        b=VTeR31xEUtHj+0eeeDy/o/3TiJDz8nwHFpwTB5vNHzcnFEVlHrflq79Rq5+6xuNKTg
         fh6M7eBVWo9hle0CFbkEs5R7OkJxxkILAcD20RvdjMgoLiqGskN3E09p8FQSY2ODKYo4
         3CgtCDeJS/LNJgZ6t5wHWxNG2EE/oq/2mGgrowbjUIzwoYyc+1tMZD0PdqVgjvgaodsN
         PW7vujZSWxmS73m3vu0M9KX7aC5i3kiEp9Arc9ti+Kd55eaj4JSYqxF4Q4/H/LiXKRK7
         z8rgoLhf7K+1q3wQr/9Lp7RVwespFz1qybfsq7IviA1P9IslVcFHRoIxVNlXe3LaaKtt
         k60g==
X-Gm-Message-State: AOJu0Yzmwx+tGp/TMhRt7PuqG2lJgWwReTV3RGEAryTQ1KI2qBAUKdxI
	PXypypskoWo860qh2fk/AocHkWRKyqfMMYp63ItHB9uKabvlqdlg4L04rPA7y3jD/S7QWzl8sBz
	tV0xBbFt7wvrcBe0E5y2dtiLRewC3fhEMwsGOcvOOlHN3U1YCp+y+HkL7R64EtsTC/WQml60/ZQ
	kL+0G7bo04SXJGyZKIXAnOL2Enp+C9miTg4CU5Tcj+MA==
X-Gm-Gg: AR+sD11Jo2Y0yy6VZSiRB/1umS9s2kBRNsMW9YQpNdn8rNZbqDaTzj7N5QfgWq3XIKH
	yUtApRjNDbIceP06hnH10PCEjCpA/8W6BCGtGRZZVdH3GGhAXoALwrfWbkLJ6PFQWiBA0m5IBfG
	t/jxRHMXAzFMTJHdGHMbrik6tirfDzp4FfdPUfFWJGuqIzXvVcBMpXZiCoKrENlBX2xetcES4RM
	UnMhkIfvsqVDMRvoNnUu3UqOuBYDa8qV1OC7HPTA+Gkz90fJkda8AAnMVDiMunzt+xm6JUpyoOw
	64Q=
X-Received: by 2002:a17:906:fe46:b0:c20:1ec5:feb8 with SMTP id a640c23a62f3a-c20c6a09bccmr231682766b.29.1786394996320;
        Mon, 10 Aug 2026 13:49:56 -0700 (PDT)
X-Received: by 2002:a17:906:fe46:b0:c20:1ec5:feb8 with SMTP id
 a640c23a62f3a-c20c6a09bccmr231680566b.29.1786394995921; Mon, 10 Aug 2026
 13:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810125726.775689-2-rrobaina@redhat.com> <D8FC4B83-AC7B-4ECC-AA70-17DCE5AB2AD6@grrlz.net>
 <CAABTaaDWFgz=kJr8YHx8NpKwuWnkCfjf==3noP36x83Zxv5APQ@mail.gmail.com> <93F6051A-4D51-4887-AED1-4BED3881FF72@grrlz.net>
In-Reply-To: <93F6051A-4D51-4887-AED1-4BED3881FF72@grrlz.net>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 10 Aug 2026 17:49:45 -0300
X-Gm-Features: AUfX_mwLdWo0v7okgYAOZekv4CUurDnHijzO6aSSt22kurZY2Uo2c-oqbhC_3E4
Message-ID: <CAABTaaCzXCJRH-LhjU_i1E4bKw1QyQ-5sanmvZPAGVhUp_D0kQ@mail.gmail.com>
Subject: Re: [PATCH] audit: use copied skb length in kauditd_send_multicast_skb()
To: Bradley Morgan <include@grrlz.net>
Cc: audit@vger.kernel.org, eparis@redhat.com, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: he7fenjsIPS8SnmMc7_-2ZztZyvPNS1orVMhGINTuaM_1786394996
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 1:28=E2=80=AFPM Bradley Morgan <include@grrlz.net> =
wrote:
>
> On 10 August 2026 16:19:10 BST, Ricardo Robaina <rrobaina@redhat.com>
> wrote:
> >On Mon, Aug 10, 2026 at 10:32=E2=80=AFAM Bradley Morgan <include@grrlz.n=
et> wrote:
> >>
> >> Hi Ricardo,
> >>
> >> > -     nlh->nlmsg_len =3D skb->len;
> >> > +     nlh->nlmsg_len =3D copy->len;
> >>
> >> Fine. skb_copy() does skb_put(n, skb->len) and nothing touches
> >> copy->len in between, so the two are always identical.
> >> Which is also why "safer" is a bit of a stretch, it prevents nothing.
> >> Feel free to bikeshed the changelog wording on that.
> >>
> >
> >Thanks for reviewing this patch, Bradley. I agree with you on the wordin=
g.
> >
>
> np.
>
> >> If you ever want a more interesting cleanup here, the real quirk is
> >> the line above: the unicast path sets nlmsg_len to skb->len minus
> >> NLMSG_HDRLEN, this one uses the full length.
> >
> >That's interesting, maybe moving the nlmsg_len fixup out of
> >__audit_log_end() would be better. I'll look into it.
> >
>
> Hmmm.. perhaps it will. I will suggest a fix:
>
> From 776375d625cd9cb138f7a6f876861bf428ae1e6c Mon Sep 17 00:00:00 2001
> From: Bradley Morgan <include@grrlz.net>
> Date: Mon, 10 Aug 2026 16:26:06 +0000
> Subject: [PATCH] audit: move the nlmsg_len fixup from __audit_log_end() t=
o
>  send time
>
> The auditd breakage (nlmsg_len set to the payload length instead of
> the full message length) is applied in __audit_log_end() when the
> record is queued. That forces kauditd_send_multicast_skb() to deep
> copy every record and undo the length on the copy, so the multicast
> group still sees a standard netlink message.
>
> Instead, finalize the header with the standard full length at queue
> time and apply the auditd length right before the unicast send in
> kauditd_send_queue(). Records stay standard netlink messages while
> they sit in the queues, and the multicast copy no longer needs its
> own fixup. The deep copy itself stays, since the auditd length
> rewrite lands in the shared data region after the copy is already
> handed to the listeners.
>
> auditd sees the same bytes as before. The fixup is computed from
> skb->len, which does not change between queueing and sending, so
> records that come back through the retry and hold queues get the same
> value again. Reply and rule list skbs are built with nlmsg_put() and
> sent on other paths, none of those are touched.
>
> This came out of the "use copied skb length" thread, where moving the
> fixup was suggested as the more interesting cleanup.
>
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
>  kernel/audit.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9412af9144bc..5b6528fc6eb5 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -802,6 +802,15 @@ static int kauditd_send_queue(struct sock *sk, u32 p=
ortid,
>                 if (skb_hook)
>                         (*skb_hook)(skb);
>
> +               /*
> +                * auditd expects nlmsg_len to be the payload length rath=
er
> +                * than the full message length.  Apply the breakage here=
 at
> +                * send time so the record stays a standard netlink messa=
ge
> +                * while queued and while it is copied for the multicast
> +                * group above.
> +                */
> +               nlmsg_hdr(skb)->nlmsg_len =3D skb->len - NLMSG_HDRLEN;
> +
>                 /* can we send to anyone via unicast? */
>                 if (!sk) {
>                         if (err_hook)
> @@ -849,7 +858,6 @@ static void kauditd_send_multicast_skb(struct sk_buff=
 *skb)
>  {
>         struct sk_buff *copy;
>         struct sock *sock =3D audit_get_sk(&init_net);
> -       struct nlmsghdr *nlh;
>
>         /* NOTE: we are not taking an additional reference for init_net s=
ince
>          *       we don't have to worry about it going away */
> @@ -859,19 +867,15 @@ static void kauditd_send_multicast_skb(struct sk_bu=
ff *skb)
>
>         /*
>          * The seemingly wasteful skb_copy() rather than bumping the refc=
ount
> -        * using skb_get() is necessary because non-standard mods are mad=
e to
> -        * the skb by the original kaudit unicast socket send routine.  T=
he
> -        * existing auditd daemon assumes this breakage.  Fixing this wou=
ld
> -        * require co-ordinating a change in the established protocol bet=
ween
> -        * the kaudit kernel subsystem and the auditd userspace code.  Th=
ere is
> -        * no reason for new multicast clients to continue with this
> -        * non-compliance.
> +        * using skb_get() is necessary because the unicast send in
> +        * kauditd_send_queue() rewrites nlmsg_len to the payload only le=
ngth
> +        * that auditd expects.  The copy shields the multicast listeners=
 from
> +        * that historical breakage, there is no reason for them to conti=
nue
> +        * with this non compliance.
>          */
>         copy =3D skb_copy(skb, GFP_KERNEL);
>         if (!copy)
>                 return;
> -       nlh =3D nlmsg_hdr(copy);
> -       nlh->nlmsg_len =3D skb->len;
>
>         nlmsg_multicast(sock, copy, 0, AUDIT_NLGRP_READLOG, GFP_KERNEL);
>  }
> @@ -2785,13 +2789,15 @@ int audit_signal_info(int sig, struct task_struct=
 *t)
>   */
>  static void __audit_log_end(struct sk_buff *skb)
>  {
> -       struct nlmsghdr *nlh;
> -
>         if (audit_rate_check()) {
> -               /* setup the netlink header, see the comments in
> -                * kauditd_send_multicast_skb() for length quirks */
> -               nlh =3D nlmsg_hdr(skb);
> -               nlh->nlmsg_len =3D skb->len - NLMSG_HDRLEN;
> +               /*
> +                * The record was built by appending data after nlmsg_put=
()
> +                * without keeping nlmsg_len up to date, so finalize the
> +                * header here with the standard full message length.  Th=
e
> +                * payload only length that auditd expects is applied at
> +                * send time in kauditd_send_queue().
> +                */
> +               nlmsg_end(skb, nlmsg_hdr(skb));
>
>                 /* queue the netlink packet */
>                 skb_queue_tail(&audit_queue, skb);
> --
> 2.47.3
>
>
>
>
> >>
> >> Well, why not, please add:
> >>
> >> Reviewed-by: Bradley Morgan <include@grrlz.net>
> >> Thanks!
> >>
> >
> >-Ricardo
> >
> >
>
> Thanks!
>

It looks good to me. I've built a kernel to test it and verified that
it passes the audit testsuite.

# uname -r
7.2.0-rc6+

# make test
make -C tests test
chmod +x */test
Running as   user    root
        with context unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
        on   system  Fedora

amcast_joinpart/test ................. ok
backlog_wait_time_actual_reset/test .. ok
bpf/test ............................. ok
coredump/test ........................ ok
exec_execve/test ..................... ok
exec_name/test ....................... ok
fanotify/test ........................ ok
field_compare/test ................... ok
file_create/test ..................... ok
file_delete/test ..................... ok
file_permission/test ................. ok
file_rename/test ..................... ok
filter_device/test ................... ok
filter_exclude/test .................. ok
filter_exit/test ..................... ok
filter_inode/test .................... ok
filter_saddr_fam/test ................ ok
filter_sessionid/test ................ ok
io_uring/test ........................ ok
login_tty/test ....................... ok
lost_reset/test ...................... ok
netfilter_pkt/test ................... ok
signal/test .......................... ok
syscalls_file/test ................... ok
syscall_module/test .................. ok
syscall_socketcall/test .............. ok
time_change/test ..................... ok
user_msg/test ........................ ok
All tests successful.
Files=3D28, Tests=3D303, 46 wallclock secs ( 0.08 usr  0.03 sys + 14.50
cusr  1.56 csys =3D 16.17 CPU)
Result: PASS

Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
Tested-by: Ricardo Robaina <rrobaina@redhat.com>

-Ricardo

